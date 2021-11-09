with source_data as (
	    select *
	    from {{ source('adventure_works','addresstype') }}
	)

	select * from source_data