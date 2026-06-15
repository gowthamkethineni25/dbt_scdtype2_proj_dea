{{
    config
    (
        materialized = 'table'
    )
}}

with session_src as 
(
    select
    session_id,
    user_id,
    browser,
    device_type,
    b.country_name as country_name,
    b.continent as continent,
    b.currency as currency,
    start_time,
    end_time,
    pages_visited,
    current_timestamp as INSERT_DTS
    from {{source('session','SESSION_SRC')}} a
    left join {{ref('country_code')}} b
    on a.country_code = b.country_code
)

select * from session_src