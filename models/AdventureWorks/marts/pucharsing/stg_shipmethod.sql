with source_data as (
	    select *
	    from {{ source('adventure_works','shipmethod') }}
	)

	select * from source_data