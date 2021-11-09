with source_data as (
	    select *
	    from {{ source('adventure_works','specialofferproduct') }}
	)

	select * from source_data