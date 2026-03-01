{% macro validate_model_name() %}

  {# -----------------------------
     CONFIGURATION
     ----------------------------- #}

  {% set allowed_prefixes = ['stg_', 'dev_', '_prod'] %}
  {% set allowed_suffixes = ['_vw', '_tbl'] %}

  {% set model_name = this.name %}

  {# -----------------------------
     PREFIX CHECK
     ----------------------------- #}

  {% set has_valid_prefix = false %}
  {% for prefix in allowed_prefixes %}
    {% if model_name.startswith(prefix) %}
      {% set has_valid_prefix = true %}
    {% endif %}
  {% endfor %}

  {# -----------------------------
     SUFFIX CHECK
     ----------------------------- #}

  {% set has_valid_suffix = false %}
  {% for suffix in allowed_suffixes %}
    {% if model_name.endswith(suffix) %}
      {% set has_valid_suffix = true %}
    {% endif %}
  {% endfor %}

  {# -----------------------------
     VALIDATION
     ----------------------------- #}

  {% if not has_valid_prefix or not has_valid_suffix %}
    {{ exceptions.raise_compiler_error(
        "❌ Invalid model name: '" ~ model_name ~ "'.\n"
        ~ "Model names must:\n"
        ~ "- Start with one of: " ~ allowed_prefixes | join(', ') ~ "\n"
        ~ "- End with one of: " ~ allowed_suffixes | join(', ')
    ) }}
  {% endif %}

{% endmacro %}
