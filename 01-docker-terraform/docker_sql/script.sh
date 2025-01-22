# Run postgres and pgadmin
docker run -it \  
  --network=pg-network \
  --name pg-database \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="1234" \
  -e POSTGRES_DB="ny_taxi" \
  -v d:/Devspace/2_Course/data_engineer_bootcamp_datatalks/data-engineering-zoomcamp/01-docker-terraform/2_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

docker run -d \
  --network=pg-network \
  --name pgadmin-1 \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  dpage/pgadmin4

URL="http://172.28.112.1:8000/green_tripdata_2019-10.csv"

# Run script on local machine
python ingest_data.py \
  --user=root \
  --password=1234 \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=green_taxi_trips
  --url=${URL}

docker build -t taxi_ingest:v003 .

# Run script in Docker build
URL="http://172.28.112.1:8000/green_tripdata_2019-10.csv"  // this is file that I want to ingest to DB.

docker run -it \
  taxi_ingest:v002 \
    --network=pg-network \
    --user=root \
    --password=1234 \
    --host=pg-database \
    --port=5432 \
    --db=ny_taxi \
    --table_name=green_taxi_trips \
    --url=${URL}
