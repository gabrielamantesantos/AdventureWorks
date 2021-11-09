with source_data as (
	    select *
	    from {{ source('adventure_works','productmodelproductdescriptionculture') }}
	)

	select * from source_data