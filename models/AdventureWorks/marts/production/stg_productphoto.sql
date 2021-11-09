with source_data as (
	    select *
	    from {{ source('adventure_works','productphoto') }}
	)

	select * from source_data