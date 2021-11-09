with source_data as (
	    select *
	    from {{ source('adventure_works','illustration') }}
	)

	select * from source_data