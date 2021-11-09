with source_data as (
	    select *
	    from {{ source('adventure_works','salesorderheadersalesreason') }}
	)

	select * from source_data