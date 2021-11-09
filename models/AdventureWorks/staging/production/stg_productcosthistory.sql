with source_data as (
	    select *
	    from {{ source('adventure_works','productcosthistory') }}
	)

	select * from source_data