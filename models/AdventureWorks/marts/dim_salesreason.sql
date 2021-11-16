{{  config(materialized='table')  }}

with
    reason as (
        select reasontype
            , salesreasonid
	        , name
        from {{ ref('stg_salesreason') }}
    )
    , reasoninfo as (
        select salesorderid
            , salesreasonid
	    from {{ ref('stg_salesorderheadersalesreason') }}
    )
    , reasonalmostfinal as (
        select reasoninfo.salesorderid
        , reasoninfo.salesreasonid
        , reason.reasontype
        , reason.name as reasonname
        from reasoninfo
        left join reason on reason.salesreasonid = reasoninfo.salesreasonid
        where reasoninfo.salesorderid is not null
    )
    , reasonfinal as (
        select salesorderid
        , string_agg(reasonname, ', ') as Reasons
        from reasonalmostfinal
        group by salesorderid
    )

select * from reasonfinal