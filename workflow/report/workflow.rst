This is the main workflow report file. From here you can do shit like this:
Here's the samples: {{ snakemake.config["samples"] }}

You've also got conditionals:

{% if snakemake.config["plot_axes_labels"]["x"] == "x" %}
This only appears if you are using the default
{% else %}
This only appears if you are not using the default
{% endif %}
