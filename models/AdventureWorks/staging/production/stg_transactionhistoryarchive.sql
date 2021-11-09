with source_data as (
	    select *
	    from {{ source('adventure_works','transactionhistoryarchive') }}
	)

	select * from source_data