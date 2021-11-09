with source_data as (
	    select *
	    from {{ source('adventure_works','salesreason') }}
	)

	select * from source_data