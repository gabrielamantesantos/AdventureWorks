with source_data as (
	    select *
	    from {{ source('adventure_works','salesorderheader') }}
	)

	select * from source_data