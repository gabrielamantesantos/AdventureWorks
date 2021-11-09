with source_data as (
	    select *
	    from {{ source('adventure_works','productcategory') }}
	)

	select * from source_data