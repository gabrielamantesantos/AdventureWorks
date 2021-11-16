{{  config(materialized='table')  }}

with creditcard as (
    select row_number() over (order by creditcardid) as creditcard_pk  /* PK */
    , cardtype
    from {{ ref('stg_creditcard') }}
)

select * from creditcard