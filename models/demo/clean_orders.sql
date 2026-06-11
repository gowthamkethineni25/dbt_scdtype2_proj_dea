{{
    config
    (
        materialized = 'ephemeral'
    )
}}

with base_orders as
(
    select
    order_id,
    order_date,
    customer_id,
    case when customer_name is null then 'NA' else upper(customer_name) end as customer_name,
    created_at
    from {{source('orders', 'BASE_ORDERS')}}
    where order_date is not null
)

select * from base_orders
