-- Columns: LocationID, Borough, Zone, service_zone
with source as (
    select * from {{ source('nyctaxi', 'taxi_zone_lookup') }}
),

-- Columns: location_id, district, zone, service_zone
renamed as (
    select
        LocationID as location_id,
        Borough as district,
        Zone as zone,
        service_zone

    from source
)

select * from renamed