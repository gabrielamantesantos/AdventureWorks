with source_data as (
	    select *
	    from {{ source('adventure_works','productsubcategory') }}
	)

	select * from source_data