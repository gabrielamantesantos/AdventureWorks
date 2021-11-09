with source_data as (
	    select *
	    from {{ source('adventure_works','businessentitycontact') }}
	)

	select * from source_data