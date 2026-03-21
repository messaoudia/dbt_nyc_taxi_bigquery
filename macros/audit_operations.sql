{% macro create_if_not_exists_audits_table() -%}

create table if not exists staging.dbt_audits (
    uuid string default (generate_uuid()),
    audit_type string,
    created_at timestamp default current_timestamp()
);

{%- endmacro %}

{% macro insert_audit(audit_type) -%}

insert into staging.dbt_audits (audit_type) values ('{{audit_type}}')

{%- endmacro %}