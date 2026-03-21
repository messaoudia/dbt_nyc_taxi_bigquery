{% docs stg_nyctaxi_raw__taxi_zone_lookup %}
Official TLC (Taxi & Limousine Commission) reference table mapping taxi zone identifiers to NYC neighborhood and borough names.

**Source:** `nyctaxi_raw_dev.taxi_zone_lookup`
**Grain:** 1 row per TLC zone (`location_id`)

Each zone represents a geographic area defined by the TLC. This table is used as a reference dimension to enrich the `fk_pickup_location_id` and `fk_dropoff_location_id` columns in trip tables.
{% enddocs %}


{% docs stg_nyctaxi_raw__yellow_tripdata %}
NYC yellow taxi trip records after column renaming from the raw source.

**Source:** `nyctaxi_raw_dev.yellow_tripdata` via `source('nyctaxi', 'yellow_tripdata')`
**Grain:** 1 row per trip

Transformations applied in this staging layer:

- Column renaming from raw names (e.g. `VendorID` → `vendor_id`, `tpep_pickup_datetime` → `pickup_ts`)
- No aggregation or filtering — all source rows are preserved

Referential integrity between `fk_pickup_location_id` / `fk_dropoff_location_id` and `stg_nyctaxi_raw__taxi_zone_lookup` is enforced via relationship tests.
{% enddocs %}


{% docs int_staging__yellow_tripdata_details %}
Enriched version of `stg_nyctaxi_raw__yellow_tripdata` with additional geographic information about pickup and dropoff zones.

**Source:** `stg_nyctaxi_raw__yellow_tripdata` enriched via joins on `us_states` and `location_state` reference tables
**Grain:** 1 row per trip (same as `yellow_tripdata`)

Additional columns compared to the parent model:
- `pickup_state_id`, `pickup_state_name`, `pickup_region`
- `dropoff_state_id`, `dropoff_state_name`, `dropoff_region`

A custom test `is_nyc_location_only` is applied on `pickup_state_name` and `dropoff_state_name` to ensure trips remain within New York State.
{% enddocs %}


{% docs col_location_id %}
Unique TLC taxi zone identifier. Primary key of the `stg_nyctaxi_raw__taxi_zone_lookup` table.

The TLC defines 265 geographic zones covering the 5 NYC boroughs and Newark Airport (EWR).
{% enddocs %}


{% docs col_district %}
NYC borough name corresponding to the TLC zone.

Possible values: `Manhattan`, `Brooklyn`, `Queens`, `Bronx`, `Staten Island`, `EWR`.
{% enddocs %}


{% docs col_zone %}
TLC taxi zone name within the borough (e.g. `Times Sq/Theatre District`, `JFK Airport`).
{% enddocs %}


{% docs col_service_zone %}
Service area category associated with the zone.

| Value | Description |
| ----- | ----------- |
| `Yellow Zone` | Core zone (Manhattan) — yellow taxis only |
| `Boro Zone` | Outer boroughs — green taxis or FHV |
| `Airports` | Airports (JFK, LaGuardia, Newark) |
{% enddocs %}


{% docs col_vendor_id %}
TPEP (Technology Service Provider) vendor ID that recorded the trip.

| Code | Vendor |
| ---- | ------ |
| `1` | Creative Mobile Technologies (CMT) |
| `2` | Curb Mobility (VeriFone) |
| `6` | Myle Technologies |
| `7` | Helix |
{% enddocs %}


{% docs col_pickup_ts %}
Date and time when the meter was engaged (trip start), as a TIMESTAMP.
{% enddocs %}


{% docs col_dropoff_ts %}
Date and time when the meter was disengaged (trip end), as a TIMESTAMP.
{% enddocs %}


{% docs col_passenger_count %}
Number of passengers in the vehicle, as reported by the driver. May be null if not entered.
{% enddocs %}


{% docs col_trip_distance %}
Trip distance in miles as reported by the taximeter.
{% enddocs %}


{% docs col_fk_rate_code_id %}
Rate code in effect at the end of the trip.

| Code | Rate |
| ---- | ---- |
| `1` | Standard rate |
| `2` | JFK |
| `3` | Newark |
| `4` | Nassau / Westchester |
| `5` | Negotiated fare |
| `6` | Group ride |
{% enddocs %}


{% docs col_store_and_fwd_flag %}
Indicates whether the trip record was held in vehicle memory before being sent to the server (e.g. no network coverage).

- `Y` — yes, trip was stored and forwarded
- `N` — no, real-time transmission
{% enddocs %}


{% docs col_fk_pickup_location_id %}
TLC zone identifier where the trip started. Foreign key to `stg_nyctaxi_raw__taxi_zone_lookup.location_id`.
{% enddocs %}


{% docs col_fk_dropoff_location_id %}
TLC zone identifier where the trip ended. Foreign key to `stg_nyctaxi_raw__taxi_zone_lookup.location_id`.
{% enddocs %}


{% docs col_payment_type %}
Payment method used by the passenger.

| Code | Method |
| ---- | ------ |
| `1` | Credit card |
| `2` | Cash |
| `3` | No charge |
| `4` | Dispute |
| `5` | Unknown |
| `6` | Voided trip |
{% enddocs %}


{% docs col_fare_amount %}
Base fare amount calculated by the meter, in USD. Does not include surcharges or tips.
{% enddocs %}


{% docs col_extra %}
Miscellaneous extras and surcharges (rush hour, overnight, etc.). Does not include tolls or taxes.
{% enddocs %}


{% docs col_mta_tax %}
$0.50 MTA tax automatically triggered based on the metered rate in use.
{% enddocs %}


{% docs col_tip_amount %}
Tip amount in USD.

> **Note:** This field is automatically populated for credit card payments only. Cash tips are **not** recorded here.

A custom test `max_tip_amount` is applied to detect outliers above the configured threshold (`var('max_tip_amount')`).
{% enddocs %}


{% docs col_tolls_amount %}
Total tolls paid during the trip, in USD.
{% enddocs %}


{% docs col_improvement_surcharge %}
$0.30 surcharge introduced in 2015 to fund taxi accessibility improvements. Fixed amount.
{% enddocs %}


{% docs col_congestion_surcharge %}
New York State congestion surcharge applied to trips entering the congestion zone (Manhattan south of 96th Street).
{% enddocs %}


{% docs col_total_amount %}
Total amount charged to the passenger, in USD. Includes base fare, surcharges, taxes, and tolls. **Excludes cash tips.**
{% enddocs %}


{% docs col_airport_fee %}
Fee applied for pickups at JFK and LaGuardia airports.
{% enddocs %}


{% docs col_cbd_congestion_fee %}
Congestion Relief Zone toll applied since January 2025 for trips entering the NYC central business district.
{% enddocs %}

{% docs col_pickup_state_id %}
Pickup state id
{% enddocs %}

{% docs col_pickup_state_name %}
Pickup state name
{% enddocs %}

{% docs col_pickup_region %}
Pickup region name
{% enddocs %}

{% docs col_pickup_district %}
Pickup district name
{% enddocs %}

{% docs col_pickup_zone %}
Pickup zone name
{% enddocs %}

{% docs col_pickup_service_zone %}
Pickup service zone name
{% enddocs %}

{% docs col_dropoff_state_id %}
Dropoff state id
{% enddocs %}

{% docs col_dropoff_state_name %}
Dropoff state name
{% enddocs %}

{% docs col_dropoff_region %}
Dropoff region name
{% enddocs %}

{% docs col_dropoff_district %}
Dropoff district name
{% enddocs %}

{% docs col_dropoff_zone %}
Dropoff zone name
{% enddocs %}

{% docs col_dropoff_service_zone %}
Dropoff service zone name
{% enddocs %}