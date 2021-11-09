with source_data as (
	    select *
	    from {{ source('adventure_works','countryregion') }}
	)

	select * from source_data