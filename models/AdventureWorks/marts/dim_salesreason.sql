{{  config(materialized='table')  }}

with
    salesreason as (
        select reasontype
            , salesreasonid
	        , name
        from {{ ref('stg_salesreason') }}
    )
    , reason as (
        select row_number() over (order by salesorderheader.salesreasonid) as reason_sk  --auto incremental surrogate key 
        , salesreason.salesreasonid as ReasonID
        , salesorderheader.salesorderid as OrderID
        , salesreason.reasontype as ReasonType
        , salesreason.name as Reason
        from {{ ref('stg_salesorderheadersalesreason') }} salesorderheader
        left join salesreason on salesorderheader.salesreasonid = salesreason.salesreasonid
    )

select * from reason