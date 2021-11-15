{{  config(materialized='table')  }}

with
    staging as (
        select *
        from {{  ref('stg_product')  }}
    )
    , transformed as (
        select
            row_number() over (order by productid) as product_sk  --auto incremental surrogate key
            , productid as ProductID
            , name as ProductName
            , productnumber as SeriesNumber
        from staging
    )

select product_sk, ProductID, ProductName, SeriesNumber from transformed
LIMIT 505