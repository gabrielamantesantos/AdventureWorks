with source_data as (
	    select *
	    from {{ source('adventure_works','customer') }}
	)

	select * from source_data