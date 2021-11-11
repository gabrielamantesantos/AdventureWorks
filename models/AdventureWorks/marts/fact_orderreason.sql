{{  config(materialized='table')  }}

with dim_orders as (
        select *
        from {{ ref('dim_salesorder')  }}
    )
    , dim_reason as (
        select *
        from {{ ref('dim_salesreason') }}
    )
    , orders_with_sk as (
        select orderheader.salesorderid as orderid
        , dim_orders.orders_sk as orders_fk 
        from {{ ref('stg_salesorderheader') }} orderheader
        left join dim_orders on dim_orders.orders_sk = orderheader.salesorderid
    )
    , reason_with_sk as (
        select orderheadersalesreason.salesorderid as orderid
        , orderheadersalesreason.salesreasonid as reasonid
        , dim_reason.reason_sk as reason_fk
        from {{ ref('stg_salesorderheadersalesreason') }} orderheadersalesreason
        left join dim_reason on dim_reason.ReasonID = orderheadersalesreason.salesreasonid
    )
    , factorderreason as (
        select reason_with_sk.reason_fk
        , orders_with_sk.orders_fk
        from orders_with_sk
        left join reason_with_sk on orders_with_sk.orderid = reason_with_sk.orderid
    )

select * from factorderreason