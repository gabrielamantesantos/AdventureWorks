with source_data as (
	    select *
	    from {{ source('adventure_works','employee') }}
	)

	select * from source_data