{{  config(materialized='table')  }}

with country as (
    select countries.name as CountryName
    , *
    from {{ref('stg_countryregion')}} countries
    )
    , stateprov as (
        select state.name as StateName
        , *
        from {{ ref('stg_stateprovince') }} state
        left join country on state.countryregioncode = country.countryregioncode
    )
    , addressfinal as (
        select address.city as CityName
        , stateprov.stateprovinceid as stateprovinceid
        , *
        from {{ref('stg_address')}} address
        left join stateprov on address.stateprovinceid = stateprov.stateprovinceid
    )
    , addressinfo as (
        select addressid as address_pk  /* PK */
            , CityName
            , StateName
            , countryName
            , addressline1
            , postalcode
        from addressfinal
    )

select * from addressinfo