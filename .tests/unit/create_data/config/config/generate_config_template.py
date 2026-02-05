from sys import argv
import yaml


class InvalidSchemaError(RuntimeError):
    """Error for if the input file isn't actually a schema."""


def generate_template_from_schema(schema_path, output_path):
    """Generate a commented config template from schema"""

    with open(schema_path) as f:
        schema = yaml.safe_load(f)

    if not isinstance(schema, dict) or "$schema" not in schema:
        raise InvalidSchemaError(
            f"The provided file is not a schema: {schema_path}"
        )

    lines = [
        "# Configuration",
        "# ==================================",
        "# Generated from schema - edit values as needed",
        "",
    ]

    def add_parameter(prop, spec, indent=0):
        indent_str = "  " * indent

        if "comment" in spec:
            for comment_line in spec["comment"].strip().split("\n"):
                lines.append(f"{indent_str}{comment_line}")
        elif "description" in spec:
            lines.append(f"{indent_str}# {spec['description']}")

        constraints = []

        if spec.get("type") == "integer":
            if "minimum" in spec:
                constraints.append(f"min: {spec['minimum']}")
            if "maximum" in spec:
                constraints.append(f"max: {spec['maximum']}")
        elif spec.get("type") == "string" and "pattern" in spec:
            pattern = spec["pattern"]
            if pattern == "^[A-Za-z_][A-Za-z0-9_]*$":
                constraints.append(
                    "must be valid R/Python identifier "
                    "(letters, numbers, underscore, starting with letter)"
                )
            elif pattern == "^[A-Za-z0-9_-]+$":
                constraints.append(
                    "alphanumeric with hyphens/underscores only"
                )

        if constraints:
            lines.append(
                f"{indent_str}# Constraints: {'; '.join(constraints)}"
            )

        if "example" in spec:
            lines.append(f"{indent_str}{prop}: {spec['example']}")
        elif "default" in spec:
            lines.append(f"{indent_str}{prop}: {spec['default']}")
        else:
            lines.append(f"{indent_str}{prop}: # REQUIRED")

        lines.append("")

    for prop in schema.get("required", []):
        if prop in schema.get("properties", {}):
            spec = schema["properties"][prop]

            if spec.get("type") == "object" and "properties" in spec:
                lines.append(f"{prop}:")
                for nested_prop in spec.get("required", []):
                    if nested_prop in spec.get("properties", {}):
                        add_parameter(
                            nested_prop,
                            spec["properties"][nested_prop],
                            indent=1,
                        )
            else:
                add_parameter(prop, spec)

    with open(output_path, "w") as f:
        f.write("\n".join(lines))

    print(f"✓ Config template generated: {output_path}")


if __name__ == "__main__":
    try:
        generate_template_from_schema(argv[1], argv[2])
    except InvalidSchemaError as e:
        print(f"Error: {e}")
    except OSError as e:
        print(f"OS Level Error: {e.errno} - {e.strerror} (for {e.filename})")
