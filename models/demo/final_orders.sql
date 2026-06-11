{{
    config 
    (
        materialized = 'table'
    )
}}

with clean_orders as 
(
    select 
    order_id,
    order_date,
    customer_id,
    customer_name,
    created_at,
    current_timestamp as INSERT_DTS
    from {{ ref('clean_orders') }}
)
select * from clean_orders