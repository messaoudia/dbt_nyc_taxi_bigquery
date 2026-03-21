with tripdata as (
    select * from {{ ref("stg_nyctaxi_raw__yellow_tripdata") }}
),

us_states as (
    select * from {{ ref("us_states") }}
),

location_state as (
    select * from {{ ref("location_state") }}
),

location_us_states as (
    select
        location_state.location_id,
        location_state.state_id,
        us_states.name,
        us_states.region

    from location_state

    left join us_states
        on location_state.state_id = us_states.state_id
),

tripdata_details as (
    select
        tripdata.*,
        pickup.state_id as pickup_state_id,
        pickup.name as pickup_state_name,
        pickup.region as pickup_region,
        dropoff.state_id as dropoff_state_id,
        dropoff.name as dropoff_state_name,
        dropoff.region as dropoff_region

    from tripdata

    left join location_us_states as pickup on
        tripdata.fk_pickup_location_id = pickup.location_id
    left join location_us_states as dropoff on
        tripdata.fk_pickup_location_id = dropoff.location_id
)

select * from tripdata_details