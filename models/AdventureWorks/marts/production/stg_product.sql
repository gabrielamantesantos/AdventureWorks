with source_data as (
	    select *
	    from {{ source('adventure_works','product') }}
	)

	select * from source_data