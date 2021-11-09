{{ config(materialized='table') }}

with
    department as (
        select
        department_sk
        from {{ ref('dim_department') }}
    )
    , shift as (
        select shift_sk
        from {{ ref('dim_shift') }}
    )
, employeedepartmenthistory as (
    select *
    from {{ ref('stg_employeedepartmenthistory') }} employeedepartmenthist
    left join department on employeedepartmenthist.departmentid = department.department_sk
    left join shift on employeedepartmenthist.shiftid = shift.shift_sk
)

select * from employeedepartmenthistory