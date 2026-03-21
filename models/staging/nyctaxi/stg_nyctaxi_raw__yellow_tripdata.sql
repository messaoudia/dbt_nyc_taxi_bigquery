

with source as (
    select * from {{ source('nyctaxi', 'yellow_tripdata') }}
),

renamed as (
    select
        VendorID as vendor_id,
        tpep_pickup_datetime as pickup_ts,
        tpep_dropoff_datetime as dropoff_ts,
        passenger_count,
        trip_distance,
        RatecodeID as fk_rate_code_id,
        store_and_fwd_flag,
        PULocationID as fk_pickup_location_id,
        DOLocationID as fk_dropoff_location_id,
        payment_type,
        fare_amount,
        extra,
        mta_tax,
        coalesce(cast(tip_amount as float64), 0.0) as tip_amount,
        coalesce(cast(tolls_amount as float64), 0.0) as tolls_amount,
        improvement_surcharge,
        congestion_surcharge,
        coalesce(cast(total_amount as float64), 0.0) as total_amount,
        Airport_fee as airport_fee,
        cbd_congestion_fee
    from source
)

select * from renamed