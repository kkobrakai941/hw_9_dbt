{% macro amount_bucket(column_name) %}
    case
        when {{ column_name }} < {{ var('low_bound', 10) }} then 'low'
        when {{ column_name }} < {{ var('medium_bound', 100) }} then 'medium'
        else 'high'
    end
{% endmacro %}
