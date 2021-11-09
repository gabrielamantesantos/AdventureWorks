with source_data as (
	    select *
	    from {{ source('adventure_works','salesterritory') }}
	)

	select * from source_data