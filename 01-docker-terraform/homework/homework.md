# Module 1 Homework: Docker & SQL

## Question 1. Understanding docker first run

Run docker with the `python:3.12.8` image in an interactive mode, use the entrypoint `bash`.

What's the version of `pip` in the image?

_solution_

![Solution Image](picture/01_solve.png)

answer is `24.3.1`

## Question 2. Understanding Docker networking and docker-compose

Given the following `docker-compose.yaml`, what is the `hostname` and `port` that **pgadmin** should use to connect to the postgres database?

```yaml
services:
  db:
    container_name: postgres
    image: postgres:17-alpine
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
      POSTGRES_DB: "ny_taxi"
    ports:
      - "5433:5432"
    volumes:
      - vol-pgdata:/var/lib/postgresql/data

  pgadmin:
    container_name: pgadmin
    image: dpage/pgadmin4:latest
    environment:
      PGADMIN_DEFAULT_EMAIL: "pgadmin@pgadmin.com"
      PGADMIN_DEFAULT_PASSWORD: "pgadmin"
    ports:
      - "8080:80"
    volumes:
      - vol-pgadmin_data:/var/lib/pgadmin

volumes:
  vol-pgdata:
    name: vol-pgdata
  vol-pgadmin_data:
    name: vol-pgadmin_data
```

![Solution Image](picture/02_solve.png)

answer is `postgres:5432`

## Question 3. Trip Segmentation Count

During the period of October 1st 2019 (inclusive) and November 1st 2019 (exclusive), how many trips, **respectively**, happened:

1. Up to 1 mile
2. In between 1 (exclusive) and 3 miles (inclusive),
3. In between 3 (exclusive) and 7 miles (inclusive),
4. In between 7 (exclusive) and 10 miles (inclusive),
5. Over 10 miles

```
SELECT
    SUM(CASE WHEN trip_distance <= 1 THEN 1 ELSE 0 END) AS up_to_1_mile,
    SUM(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 ELSE 0 END) AS between_1_and_3_miles,
    SUM(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 ELSE 0 END) AS between_3_and_7_miles,
    SUM(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 ELSE 0 END) AS between_7_and_10_miles,
    SUM(CASE WHEN trip_distance > 10 THEN 1 ELSE 0 END) AS over_10_miles
FROM green_taxi_trips
WHERE lpep_pickup_datetime >= '2019-10-01'
  AND lpep_dropoff_datetime < '2019-11-01';
```

![Solution Image](picture/03_solve.png)

answer is `104,802;  198,924;  109,603;  27,678;  35,189`

## Question 4. Longest trip for each day

Which was the pick up day with the longest trip distance?
Use the pick up time for your calculations.

Tip: For every day, we only care about one single trip with the longest distance.

![Solution Image](picture/04_solve.png)

answer is `2019-10-11`

## Question 5. Three biggest pickup zones

Which were the top pickup locations with over 13,000 in
`total_amount` (across all trips) for 2019-10-18?

Consider only `lpep_pickup_datetime` when filtering by date.

![Solution Image](picture/05_solve.png)

```
SELECT tz."Zone", SUM(tp."total_amount")
FROM green_taxi_trips tp
INNER JOIN taxi_zone tz
	ON tp."PULocationID" = tz."LocationID"
WHERE tp.lpep_pickup_datetime >= '2019-10-18'
	AND tp.lpep_pickup_datetime < '2019-10-19'
GROUP BY tz."Zone"
ORDER BY SUM(tp."total_amount") DESC
LIMIT 3;
```

answer is `East Harlem North, East Harlem South, Morningside Heights`

## Question 6. Largest tip

For the passengers picked up in October 2019 in the zone
named "East Harlem North" which was the drop off zone that had
the largest tip?

Note: it's `tip` , not `trip`

We need the name of the zone, not the ID.

![Solution Image](picture/06_solve.png)

```
SELECT tzd."Zone" AS drop_off_zone, MAX(tp.tip_amount) AS tips
FROM green_taxi_trips tp
LEFT JOIN taxi_zone tzp
ON tp."PULocationID" = tzp."LocationID"
LEFT JOIN taxi_zone tzd
ON tp."DOLocationID" = tzd."LocationID"
WHERE tp.lpep_pickup_datetime >= '2019-10-1'
	AND tp.lpep_pickup_datetime < '2019-11-1'
	AND tzp."Zone" = 'East Harlem North'
GROUP BY tzd."Zone"
ORDER BY MAX(tp.tip_amount) DESC
LIMIT 1;
```

answer is `JFK Airport`

## Question 7. Terraform Workflow

Which of the following sequences, **respectively**, describes the workflow for:

1. Downloading the provider plugins and setting up backend,
2. Generating proposed changes and auto-executing the plan
3. Remove all resources managed by terraform`

![Solution Image](picture/07_solve.png)

`answer is ?`
