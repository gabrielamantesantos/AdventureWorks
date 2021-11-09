with source_data as (
	    select *
	    from {{ source('adventure_works','salesterritoryhistory') }}
	)

	select * from source_data