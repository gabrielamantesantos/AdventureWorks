with source_data as (
	    select *
	    from {{ source('adventure_works','productmodel') }}
	)

	select * from source_data