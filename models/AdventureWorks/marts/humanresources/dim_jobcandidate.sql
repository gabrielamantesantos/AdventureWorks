{{ config(materialized='table') }}

with
    staging as(
        select *
        from {{ ref('stg_jobcandidate') }}
)

select * from staging