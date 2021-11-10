{{  config(materialized='table')  }}

with country as (
    select countries.name as country_name
    , *
    from {{ref('stg_countryregion')}} countries
    )
    , stateprov as (
        select state.name as state_name
        , *
        from {{ ref('stg_stateprovince') }} state
        left join country on state.countryregioncode = country.countryregioncode
    )
    , addressfinal as (
        select address.city as city_name
        , stateprov.stateprovinceid as stateprovinceid
        , *
        from {{ref('stg_address')}} address
        left join stateprov on address.stateprovinceid = stateprov.stateprovinceid
    )
    , addressinfo as (
        select city_name
            , postalcode
            , addressline1
            , addressid
            , state_name
            , territoryid
            , country_name
        from addressfinal
    )

select * from addressinfo

    