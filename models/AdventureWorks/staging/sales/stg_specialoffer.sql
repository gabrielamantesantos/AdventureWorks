with source_data as (
	    select *
	    from {{ source('adventure_works','specialoffer') }}
	)

	select * from source_data