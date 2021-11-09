with source_data as (
	    select *
	    from {{ source('adventure_works','purchaseorderheader') }}
	)

	select * from source_data