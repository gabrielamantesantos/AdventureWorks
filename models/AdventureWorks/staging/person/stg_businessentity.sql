with source_data as (
	    select *
	    from {{ source('adventure_works','businessentity') }}
	)

	select * from source_data