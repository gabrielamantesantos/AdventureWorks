with source_data as (
	    select *
	    from {{ source('adventure_works','productdocument') }}
	)

	select * from source_data