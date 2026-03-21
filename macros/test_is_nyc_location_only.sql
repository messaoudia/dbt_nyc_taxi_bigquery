{% test is_nyc_location_only(model, column_name) %}

with validation as (

    select
        {{ column_name }} as city

    from {{ model }}

),

validation_errors as (

    select
        city

    from validation
    -- if this is true, then even_field is actually odd!
    where city != 'New York'

)

select *
from validation_errors

{% endtest %}