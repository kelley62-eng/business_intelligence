# Airbnb Market Analysis (Assignment 06)

Eight dplyr analyses of Airbnb listings in Chicago, Columbus, and the Twin Cities. The code is in `airbnb_analysis.Rmd` and the knitted report is `airbnb_analysis.html`.

## Five findings

1. Hosts with ten or more listings hold 37.1 percent of Columbus's listings but only 17.2 percent of the Twin Cities', so Columbus is much more of a professional-operator market.
2. North Linden is the best value in Columbus for a family of four: well-reviewed entire homes there cost a median $32.55 per person per night.
3. The top 10 percent of Columbus listings earn 36.1 percent of the city's estimated revenue, so a small group of listings takes a big share of the money.
4. Twin Cities listings got 2.37 times as many reviews in August 2025 as in February 2026, so hosts there should plan for a big summer-to-winter swing in demand.
5. Superhosts charge $43.75 more than other hosts in Chicago but $1.38 less in the Twin Cities, so the badge doesn't bring a price premium everywhere.

## Data note

456 listings have no rows in the availability table, so joins with that table drop them; Chicago loses the most (267), then the Twin Cities (120) and Columbus (69).