with source_data as (
	    select *
	    from {{ source('adventure_works','document') }}
	)

	select * from source_data