with source_data as (
	    select *
	    from {{ source('adventure_works','stateprovince') }}
	)

	select * from source_data