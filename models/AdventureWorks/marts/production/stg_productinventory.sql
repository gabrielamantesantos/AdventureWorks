with source_data as (
	    select *
	    from {{ source('adventure_works','productinventory') }}
	)

	select * from source_data