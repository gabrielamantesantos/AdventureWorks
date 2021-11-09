{{ config(materialized='table') }}

with
    staging as(
        select *
        from {{ ref('stg_department') }}
)
    , transformed as (
        select
            row_number() over (order by departmentid) as department_sk  --auto incremental surrogate key
            , name
            , groupname
            , modifieddate
            , _sdc_table_version
            , _sdc_sequence
            , _sdc_received_at
            , _sdc_batched_at
        from staging
)
select * from transformed