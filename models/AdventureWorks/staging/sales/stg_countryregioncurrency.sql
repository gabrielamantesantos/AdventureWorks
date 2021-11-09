with source_data as (
	    select *
	    from {{ source('adventure_works','countryregioncurrency') }}
	)

	select * from source_data