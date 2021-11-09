with source_data as (
	    select *
	    from {{ source('adventure_works','productdescription') }}
	)

	select * from source_data