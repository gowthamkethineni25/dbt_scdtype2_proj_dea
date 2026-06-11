{{
    config 
    (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'purchase_id',
        merge_exclude_columns = ['INSERT_DTS']
    )
}}

with purchase_src as 
(
    select
    purchase_id,
    purchase_date,
    purchase_status,
    created_at,
    current_timestamp as INSERT_DTS,
    current_timestamp as UPDATE_DTS
    from {{source('purchase','PURCHASE_SRC')}}

    {% if is_incremental() %}
    where created_at > (select max(UPDATE_DTS) from {{this}})
    {% endif %}
)
select * from purchase_src