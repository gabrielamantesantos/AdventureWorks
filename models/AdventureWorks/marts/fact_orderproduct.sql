{{  config(materialized='table')  }}

with dim_orders as (
        select *
        from {{ ref('dim_salesorder')  }}
    )
    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )
    , orders_with_sk as (
            select orderheader.salesorderid as orderid
            , dim_orders.orders_sk as orders_fk
            , orderheader.freight as frete
            from {{ ref('stg_salesorderheader') }} orderheader
        left join dim_orders on dim_orders.orders_sk = orderheader.salesorderid
    )
    , orders_with_products as (
        select orderdetail.salesorderid as OrderID
            , dim_products.product_sk as product_fk
            , orderdetail.salesorderdetailid as OrderDetailID
            , orderdetail.orderqty as OrderQuantity
            , orderdetail.unitprice as UnitPrice
            , orderdetail.unitpricediscount as Discount
        from {{ ref('stg_salesorderdetail') }} orderdetail
        left join dim_products on dim_products.ProductID = orderdetail.productid
    )
    , factorderproduct as (
        select OrderQuantity*UnitPrice as GrossIncome
        , *
        from orders_with_products
    )

    select OrderID, product_fk, OrderDetailID, OrderQuantity, UnitPrice, GrossIncome, Discount
    from factorderproduct
    LIMIT 10000