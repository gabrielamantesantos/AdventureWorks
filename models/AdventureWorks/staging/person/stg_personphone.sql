with source_data as (
	    select *
	    from {{ source('adventure_works','personphone') }}
	)

	select * from source_data