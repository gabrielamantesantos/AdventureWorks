with source_data as (
	    select *
	    from {{ source('adventure_works','culture') }}
	)

	select * from source_data