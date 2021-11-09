with source_data as (
	    select *
	    from {{ source('adventure_works','salespersonquotahistory') }}
	)

	select * from source_data