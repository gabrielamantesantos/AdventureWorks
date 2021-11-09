with source_data as (
	    select *
	    from {{ source('adventure_works','billofmaterials') }}
	)

	select * from source_data