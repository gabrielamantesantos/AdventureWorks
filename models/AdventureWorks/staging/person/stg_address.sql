with source_data as (
	    select *
	    from {{ source('adventure_works','address') }}
	)

	select * from source_data