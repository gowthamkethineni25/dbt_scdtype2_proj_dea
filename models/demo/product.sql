{{
    config
    (
        materialized = 'incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'product_id'
    )
}}

with product_src as 
(
    select
    product_id,
    product_name,
    product_price,
    created_at,
    current_timestamp as INSERT_DTS
    from {{source('product', 'PRODUCT_SRC')}}
    {% if is_incremental() %}
    where created_at > (select max(INSERT_DTS) from {{this}})
    {% endif %}
)

select * from product_src