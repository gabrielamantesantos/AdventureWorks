with source_data as (
	    select *
	    from {{ source('adventure_works','department') }}
	)

	select * from source_data
