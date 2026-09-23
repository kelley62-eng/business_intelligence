# Midwest Airbnb Listings: Data Dictionary

**Dataset:** `listings` table in `midwest_airbnb.db` (SQLite), 14,887 rows and 29 columns
**Source:** Inside Airbnb (https://insideairbnb.com/get-the-data/), the detailed `listings.csv.gz` file for each of three regions: Chicago (snapshot 2026-07-20), Columbus (snapshot 2026-07-23), and Twin Cities MSA (snapshot 2026-07-21). Column meanings follow Inside Airbnb's data dictionary and assumptions (https://insideairbnb.com/data-assumptions/).
**Course:** ISA 401, Miami University

> One row is one listing that showed a nightly price on the snapshot date; listings with no price were dropped. Empty cells are stored as SQL `NULL`.

---

## Field Definitions

| Field | Type | Description |
|---|---|---|
| `city` | text | Which Inside Airbnb region the listing came from: `Chicago` (7,439 rows), `Columbus` (2,587), or `Twin Cities` (4,861). The Twin Cities file covers the Minneapolis-St. Paul metro area, not just the two cities. |
| `snapshot_date` | text | Date Inside Airbnb compiled the file, stored as an ISO text string, not a date: `2026-07-20` for Chicago, `2026-07-23` for Columbus, `2026-07-21` for Twin Cities. Every row of a city shares the same value. |
| `id` | text | Airbnb's listing id. Unique across the table (14,887 distinct values). Stored as text even though it looks numeric, so compare it to a quoted string. |
| `name` | text | Listing title as shown on Airbnb (for example "Tiny Studio Apartment 94 Walk Score"). Never empty. |
| `price` | real | Nightly price in U.S. dollars on the snapshot date, with the dollar sign and commas removed. Ranges from 2.56 to 11,412; never `NULL` (rows without a price were dropped). |
| `room_type` | text | Airbnb's four listing categories: `Entire home/apt` (11,652 rows), `Private room` (2,951), `Hotel room` (246), or `Shared room` (38). |
| `host_id` | text | Airbnb's id for the host. Stored as text, so compare it to a quoted string. 6,970 distinct hosts; one host can have many listings, so count hosts with `COUNT(DISTINCT host_id)`, not by name. |
| `host_name` | text | Host's first name or business name as shown on Airbnb. Not unique (many different hosts share a name like "David"), so use `host_id` to identify a host. 25 rows are `NULL`. |
| `host_since` | text | Date the host joined Airbnb. Empty in this dataset: every row is `NULL`, so it cannot be used to answer questions. |
| `host_is_superhost` | text | Whether the host has Airbnb's Superhost status: `t` (true) or `f` (false). 25 rows are `NULL`. |
| `neighbourhood` | text | Neighbourhood the listing is in, from Inside Airbnb's `neighbourhood_cleansed` column (for example `Albany Park`). 119 distinct values across the three regions; names are only meaningful together with `city`. |
| `latitude` | real | Latitude of the listing, in decimal degrees. Ranges from about 39.88 to 46.24. Airbnb shifts locations slightly for privacy, so treat it as approximate. |
| `longitude` | real | Longitude of the listing, in decimal degrees (negative = west). Ranges from about -94.53 to -82.78. Approximate, like `latitude`. |
| `property_type` | text | Airbnb's detailed property type, finer than `room_type` (62 distinct values, alphabetically from `Barn` to `Yurt`). |
| `accommodates` | integer | Maximum number of guests the listing can host. Ranges from 1 to 16; never `NULL`. |
| `bedrooms` | real | Number of bedrooms. Ranges from 1 to 16; 2,976 rows are `NULL` (often studios or unreported). |
| `beds` | real | Number of beds. Ranges from 1 to 32; 668 rows are `NULL`. |
| `bathrooms_text` | text | Bathrooms as Airbnb's text label (for example `1 bath`, `2.5 baths`, `Shared half-bath`), so it is text, not a number. 32 distinct values; 71 rows are `NULL`. |
| `minimum_nights` | integer | Minimum number of nights a guest must book. Ranges from 1 to 365; 15 rows are `NULL`. |
| `availability_365` | integer | Number of days in the next 365 (from the snapshot date) that the listing is open to book. Ranges from 0 to 365; 0 means fully booked or blocked. |
| `number_of_reviews` | integer | Total number of reviews the listing has ever received. Ranges from 0 to 2,246. |
| `number_of_reviews_ltm` | integer | Number of reviews in the last twelve months before the snapshot date. Ranges from 0 to 1,220. |
| `first_review` | text | Date of the listing's first review, stored as ISO text (`YYYY-MM-DD`), not a date. Ranges from 2009-07-03 to 2026-07-20; `NULL` for the 1,761 listings with no reviews. |
| `last_review` | text | Date of the listing's most recent review, stored as ISO text (`YYYY-MM-DD`). Ranges from 2014-08-23 to 2026-07-22; `NULL` for the 1,761 listings with no reviews. |
| `review_scores_rating` | real | Average overall guest rating on a 1 to 5 scale. `NULL` for the 1,761 listings with no reviews; ignore `NULL`s rather than treating them as zero. |
| `reviews_per_month` | real | Average number of reviews per month over the listing's life. Ranges from 0.01 to 77.72; `NULL` for listings with no reviews. |
| `instant_bookable` | text | Whether guests can book without host approval. Empty in this dataset: every row is `NULL`, so it cannot be used to answer questions. |
| `estimated_revenue_l365d` | real | Inside Airbnb's estimate of the listing's revenue over the last 365 days, in U.S. dollars (based on nightly price and estimated booked nights). Ranges from 0 to 1,114,800; it is a model estimate, not reported income, and very large values may reflect bad prices. |
| `amenities_count` | integer | Number of amenities the listing advertises (Wi-Fi, kitchen, parking, and so on). Computed for this course by counting the items in Inside Airbnb's `amenities` list; not an Inside Airbnb column. Ranges from 0 to 100. |

