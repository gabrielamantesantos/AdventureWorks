{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_product')  }}
    )
    , transformed as (
        select
            row_number() over (order by productid) as product_pk  --auto incremental surrogate key
            , name as ProductName
            , productnumber as SeriesNumber
        from staging
    )

select product_pk, ProductName, SeriesNumber from transformed
LIMIT 505