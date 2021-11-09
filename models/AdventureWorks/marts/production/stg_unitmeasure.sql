with source_data as (
	    select *
	    from {{ source('adventure_works','unitmeasure') }}
	)

	select * from source_data