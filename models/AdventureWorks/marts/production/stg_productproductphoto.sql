with source_data as (
	    select *
	    from {{ source('adventure_works','productproductphoto') }}
	)

	select * from source_data