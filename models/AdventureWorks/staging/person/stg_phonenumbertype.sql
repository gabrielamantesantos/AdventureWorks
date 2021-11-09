with source_data as (
	    select *
	    from {{ source('adventure_works','phonenumbertype') }}
	)

	select * from source_data