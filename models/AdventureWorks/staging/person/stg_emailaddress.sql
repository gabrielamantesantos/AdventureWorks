with source_data as (
	    select *
	    from {{ source('adventure_works','emailaddress') }}
	)

	select * from source_data