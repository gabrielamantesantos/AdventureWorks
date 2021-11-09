with source_data as (
	    select *
	    from {{ source('adventure_works','password') }}
	)

	select * from source_data