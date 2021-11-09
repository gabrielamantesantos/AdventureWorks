with source_data as (
	    select *
	    from {{ source('adventure_works','person') }}
	)

	select * from source_data