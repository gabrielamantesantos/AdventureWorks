with source_data as (
	    select *
	    from {{ source('adventure_works','productreview') }}
	)

	select * from source_data