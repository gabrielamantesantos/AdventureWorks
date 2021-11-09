{{ config(materialized='table') }}

with
    employeedepartmenthistory as (
        select
        shift_sk
        from {{ ref('dim_employeedepartmenthistory') }}
    )
    , jobcandidate as (
        select businessentityid
        from {{ ref('dim_jobcandidate') }}
    )
    , employeepayhistory as (
    select modifieddate
        from {{ ref('dim_employeepayhistory') }}
    )
, employee_final as (
    select *
    from {{ ref('stg_employee') }} employee
    left join employeedepartmenthistory on employee.shift_sk = employeedepartmenthistory.shift_sk
    left join jobcadidate on employee.businessentityid = jobcandidate.businessentityid
    left join employeepayhistory on employee.modifieddate = employeepayhistory.modifieddate
)

select * from employee_final