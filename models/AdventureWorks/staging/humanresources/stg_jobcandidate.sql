with source_data as (
	    select *
	    from {{ source('adventure_works','jobcandidate') }}
	)

	select * from source_data