with source_data as (
	    select *
	    from {{ source('adventure_works','purchaseorderdetail') }}
	)

	select * from source_data