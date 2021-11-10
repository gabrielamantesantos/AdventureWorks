{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_product')  }}
    )
    , transformed as (
        select
            row_number() over (order by productid) as product_sk  --auto incremental surrogate key
            , *
        from staging
    )

select * from transformed