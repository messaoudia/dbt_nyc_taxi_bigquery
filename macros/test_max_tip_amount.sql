{% test max_tip_amount(model, column_name) %}

with validation as (

    select
        {{ column_name }} as tip_amount

    from {{ model }}

),

validation_errors as (

    select
        tip_amount

    from validation
    -- if this is true, then even_field is actually odd!
    where tip_amount > {{ var("max_tip_amount") }}

)

select *
from validation_errors

{% endtest %}