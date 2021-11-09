with source_data as (
	    select *
	    from {{ source('adventure_works','currencyrate') }}
	)

	select * from source_data