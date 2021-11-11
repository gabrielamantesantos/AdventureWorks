{{  config(materialized='table')  }}

with person as (
        select *
        from {{ ref('stg_person') }}
    )
    , creditcard as (
        select *
        from {{ ref('stg_creditcard')}}
    )
    , orderdetails as (
        select *
        from {{ ref('stg_salesorderdetail') }}
    )
    , addressinfo as (
        select *
        from {{ ref('dim_address') }}
    )
    , orders as (
        select *
        from {{ ref('stg_salesorderheader') }}
    )
    , customer as (
        select *
        from {{ ref('stg_customer') }}
    )
    , orderfinal as (
        select
            row_number() over (order by orders.salesorderid) as orders_sk  --auto incremental surrogate key
            , orders.salesorderid as OrderID
            , orders.orderdate as OrderDate
            , extract(year from orders.orderdate) as OrderYear
            , extract(month from orders.orderdate) as OrderMonth
            , case
                when orders.status = 1 then 'In Process'
                when orders.status = 2 then 'Approved'
                when orders.status = 3 then 'Waiting'
                when orders.status = 4 then 'Rejected'
                when orders.status = 5 then 'Shipped'
                when orders.status = 6 then 'Canceled'
            end as Status
            , addressinfo.city_name as CityName
            , addressinfo.state_name as StateName
            , addressinfo.country_name as CountryName
            , concat(if(title is null, ' ', person.title), ' ', person.firstname, ' ', person.lastname) as CustomerName
        from orders
        left join customer on orders.customerid = customer.customerid
        left join person on customer.personid = person.businessentityid
        left join creditcard on orders.creditcardid = creditcard.creditcardid
        left join addressinfo on orders.shiptoaddressid = addressinfo.addressid
        left join orderdetails on orders.salesorderid = orderdetails.salesorderid
)

select * from orderfinal