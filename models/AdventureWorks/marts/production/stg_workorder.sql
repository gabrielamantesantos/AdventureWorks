with source_data as (
	    select *
	    from {{ source('adventure_works','workorder') }}
	)

	select * from source_data