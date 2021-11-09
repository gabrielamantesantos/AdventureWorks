with source_data as (
	    select *
	    from {{ source('adventure_works','employeepayhistory') }}
	)

	select * from source_data