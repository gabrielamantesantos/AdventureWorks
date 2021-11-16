{{  config(materialized='table')  }}

with addressinfo as (
  select *
  from {{ ref('dim_address') }}
  )
, creditcard as (
  select *
  from {{ ref('dim_creditcard') }}
  )
, customer as (
  select *
  from {{ ref('dim_customer') }}
  )
, product as (
  select *
  from {{ ref('dim_products') }}
  )
, salesreason as (
  select *
  from {{ ref('dim_salesreason') }}
  )
    /* Construção da Fact Orders */
, orders_with_sk as (
  select customer.customer_pk as customer_fk
  , customer.CustomerName
  , orderheader.salesorderid
  , orderheader.billtoaddressid as address_fk
  , orderheader.creditcardid as creditcard_fk
  , orderheader.orderdate
  , salesreason.Reasons
  , case
  when orderheader.status = 1 then 'In Process'
  when orderheader.status = 2 then 'Approved'
  when orderheader.status = 3 then 'Waiting'
  when orderheader.status = 4 then 'Rejected'
  when orderheader.status = 5 then 'Shipped'
  when orderheader.status = 6 then 'Cancelled'
  end as Status
  from {{ ref('stg_salesorderheader') }} as orderheader
  left join salesreason on orderheader.salesorderid = salesreason.salesorderid
  left join customer on orderheader.customerid = customer.customer_pk
)
, detail_with_sk as (
    select product.product_pk as product_fk
        , product.ProductName
        , orderdetail.salesorderid
        , orderdetail.salesorderdetailid
        , orderdetail.orderqty			
        , orderdetail.unitprice	
        , orderdetail.unitpricediscount
    from {{ ref('stg_salesorderdetail') }} as orderdetail
    left join product on orderdetail.productid = product.product_pk
)
, factorders as (
    select orders_with_sk.customer_fk
        , orders_with_sk.address_fk
        , orders_with_sk.customername
        , orders_with_sk.salesorderid
        , orders_with_sk.orderdate
        , extract(year from orders_with_sk.orderdate) as OrderYear
        , extract(month from orders_with_sk.orderdate) as OrderMonth
        , orders_with_sk.Status
        , detail_with_sk.salesorderdetailid
        , detail_with_sk.product_fk
        , detail_with_sk.productname
        , detail_with_sk.orderqty			
        , detail_with_sk.unitprice	
        , detail_with_sk.unitpricediscount
        , addressinfo.CityName
        , addressinfo.StateName
        , addressinfo.CountryName
        , creditcard.cardtype as CardType
    from orders_with_sk
    left join detail_with_sk on orders_with_sk.salesorderid = detail_with_sk.salesorderid
    left join addressinfo on orders_with_sk.address_fk = addressinfo.address_pk
    left join creditcard on orders_with_sk.creditcard_fk = creditcard.creditcard_pk
)
, factgross as (
    select unitprice*orderqty as GrossIncome
    , *
    from factorders
)

select customer_fk, CustomerName, salesorderid, orderdate, OrderYear, OrderMonth, Status, product_fk, address_fk, ProductName, orderqty, unitprice, GrossIncome, unitpricediscount

from factgross