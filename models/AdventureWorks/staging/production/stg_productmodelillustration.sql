with source_data as (
	    select *
	    from {{ source('adventure_works','productmodelillustration') }}
	)

	select * from source_data