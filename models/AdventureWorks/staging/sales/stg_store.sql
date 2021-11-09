with source_data as (
	    select *
	    from {{ source('adventure_works','store') }}
	)

	select * from source_data