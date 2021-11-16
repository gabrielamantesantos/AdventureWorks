{{  config(materialized='table')  }}

with
    customerinfo as (
        select customerid
            , personid
            , storeid	
        from {{ ref('stg_customer') }} customer
    )
    , personinfo as (
        select businessentityid
        , concat(if(title is null, ' ', person.title), ' ', person.firstname, ' ', person.lastname) as PersonName
        from {{ ref('stg_person') }} person
    )
    , storeinfo as (
        select businessentityid as storeid
		, name as StoreName
        from {{ ref('stg_store') }} store
    ) 
    , customerfinal as (
        select row_number() over (order by customerinfo.customerid) as customer_pk  --auto incremental surrogate key
        /* , customerinfo.customerid */
        , personinfo.businessentityid
        /* , personinfo.PersonName */
        , storeinfo.storeid
        /* , storeinfo.storename */
        , case
        when personinfo.PersonName is not null
        then personinfo.PersonName
        else storeinfo.storename
        end as CustomerName
        from customerinfo
        left join personinfo on customerinfo.personid = personinfo.businessentityid
        left join storeinfo on customerinfo.storeid = storeinfo.storeid
    )

select customer_pk, storeid, CustomerName from customerfinal