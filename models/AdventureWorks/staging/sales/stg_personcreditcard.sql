with source_data as (
	    select *
	    from {{ source('adventure_works','personcreditcard') }}
	)

	select * from source_data