with source_data as (
	    select *
	    from {{ source('adventure_works','salesperson') }}
	)

	select * from source_data