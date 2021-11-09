with source_data as (
	    select *
	    from {{ source('adventure_works','salestaxrate') }}
	)

	select * from source_data