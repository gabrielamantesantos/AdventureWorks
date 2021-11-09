with source_data as (
	    select *
	    from {{ source('adventure_works','businessentityaddress') }}
	)

	select * from source_data