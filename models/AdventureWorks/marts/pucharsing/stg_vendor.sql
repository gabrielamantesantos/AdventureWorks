with source_data as (
	    select *
	    from {{ source('adventure_works','vendor') }}
	)

	select * from source_data