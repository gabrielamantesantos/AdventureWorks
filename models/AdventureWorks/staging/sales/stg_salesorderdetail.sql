with source_data as (
	    select *
	    from {{ source('adventure_works','salesorderdetail') }}
	)

	select * from source_data