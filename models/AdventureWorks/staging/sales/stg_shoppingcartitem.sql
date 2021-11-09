with source_data as (
	    select *
	    from {{ source('adventure_works','shoppingcartitem') }}
	)

	select * from source_data