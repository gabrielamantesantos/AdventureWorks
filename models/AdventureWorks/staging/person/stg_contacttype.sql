with source_data as (
	    select *
	    from {{ source('adventure_works','contacttype') }}
	)

	select * from source_data