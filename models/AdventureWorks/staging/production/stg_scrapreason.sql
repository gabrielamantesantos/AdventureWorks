with source_data as (
	    select *
	    from {{ source('adventure_works','scrapreason') }}
	)

	select * from source_data