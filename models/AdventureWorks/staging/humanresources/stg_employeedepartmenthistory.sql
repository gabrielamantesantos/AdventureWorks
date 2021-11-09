with source_data as (
	    select *
	    from {{ source('adventure_works','employeedepartmenthistory') }}
	)

	select * from source_data