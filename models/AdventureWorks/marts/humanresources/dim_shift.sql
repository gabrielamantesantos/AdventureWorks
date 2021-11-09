{{ config(materialized='table') }}

with
    staging as(
        select *
        from {{ ref('stg_shift') }}
)
    , transformed as (
        select
            shiftid as shift_sk  --auto incremental surrogate key
            , name
            , starttime
            , endtime
            , modifieddate
            , _sdc_table_version
            , _sdc_sequence
            , _sdc_received_at
            , _sdc_batched_at
        from staging
)
select * from transformed