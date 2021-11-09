with source_data as (
	    select *
	    from {{ source('adventure_works','creditcard') }}
	)

	select * from source_data