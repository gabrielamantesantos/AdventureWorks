{{  config(materialized='table')  }}

with
    salesreason as (
        select reasontype
            , salesreasonid
	        , name
        from {{ ref('stg_salesreason') }}
    )
    , reason as (
        select salesreason.salesreasonid
        , salesorderheader.salesorderid
        , salesreason.reasontype
        , salesreason.name
        from {{ ref('stg_salesorderheadersalesreason') }} salesorderheader
        left join salesreason on salesorderheader.salesreasonid = salesreason.salesreasonid
    )

select * from reason