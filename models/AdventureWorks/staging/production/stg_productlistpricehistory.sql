with source_data as (
	    select *
	    from {{ source('adventure_works','productlistpricehistory') }}
	)

	select * from source_data