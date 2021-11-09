with source_data as (
	    select *
	    from {{ source('adventure_works','transactionhistory') }}
	)

	select * from source_data