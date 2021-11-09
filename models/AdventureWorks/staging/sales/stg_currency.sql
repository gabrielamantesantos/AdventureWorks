with source_data as (
	    select *
	    from {{ source('adventure_works','currency') }}
	)

	select * from source_data