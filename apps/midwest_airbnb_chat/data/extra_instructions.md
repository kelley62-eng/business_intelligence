# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks what something costs, use `price` and round money to whole dollars in the answer.

- `host_is_superhost` is stored as the text values `'t'` and `'f'`, not as booleans. Filter superhosts with `host_is_superhost = 't'` and non-superhosts with `host_is_superhost = 'f'`.
- `city` has exactly three values: `'Chicago'`, `'Columbus'`, and `'Twin Cities'`. If the user mentions Minneapolis, St. Paul, or the Twin Cities, filter on `city = 'Twin Cities'`.
- When searching listing titles in `name`, match case-insensitively with `LOWER(name) LIKE '%word%'`.
- When averaging `review_scores_rating`, leave out listings where it is `NULL` (never treat a missing rating as zero), and say how many listings the average is based on.
- `host_since` and `instant_bookable` are empty (every row is `NULL`). If a question needs either one, tell the user the data does not include it instead of writing a query.
- To count hosts, use `COUNT(DISTINCT host_id)`, never `host_name`, because different hosts can share a name.