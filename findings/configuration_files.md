# Configuration Files

You can specify the config file to use on the command line. This means it
should (in my opinion) be best practice to provide an example config file with
the repo and then people can copy this and make their changes. This way
multiple runs can be made yadah yadah yadah (same thing that's been said loads
of times before). What is nice is that the way snakemake uses the configuration
file causes it to be somewhat verified automatically. You can at the very
least ensure that all entries do indeed exist in the file (in case their config
file is outdated).

## Explicit checking

So there is a way to explicitly check the configuration file (with types and
all). You'd need to make a schema and then explictly validate it.

```
$schema: "http://json-schema.org/draft-06/schema#"

description: an entry in the sample sheet
properties:
  sample:
    type: string
    description: sample name/identifier
  condition:
    type: string
    description: sample condition that will be compared during differential expression analysis (e.g. a treatment, a tissue time, a disease)
  case:
    type: boolean
    default: true
    description: boolean that indicates if sample is case or control

required:
  - sample
  - condition
```

There's one bit I hate here, and that would be the fact that there is very
poor coupling between the schema and any example config files you want to give
for the user to actually edit. The best thing I can think of (that's not overly
advanced) would be to make a script that generates the example config file from
this schema.

### Problems

So there's a big problem in snakemake right now that means you cannot really
pick the schema you want. The problem is two fold as the docs incorrectly state
what you can do. I've made my own fix, but I kept failing to adhere to all of
snakemake's different rules in place (set by maintainer). For now you'd want
to update the snakemake environment by grabbing my
[fork](https://github.com/sof202/snakemake/) and installing that via pip.

For more information on this you could go and look at the
[issue](https://github.com/snakemake/snakemake/issues/3963) and
[pr](https://github.com/snakemake/snakemake/pull/3965) I made.
