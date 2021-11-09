with source_data as (
	    select *
	    from {{ source('adventure_works','shift') }}
	)

	select * from source_data
