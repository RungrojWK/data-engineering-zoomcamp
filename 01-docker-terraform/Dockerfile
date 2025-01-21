FROM python:3.12.8

RUN apt-get update && apt-get install -y wget
RUN pip install pandas sqlalchemy psycopg2-binary

WORKDIR /app
COPY ../2_docker_sql/ingest_data.py ingest_data.py
# COPY ../2_docker_sql/yellow_tripdata_2021-01.csv yellow_tripdata_2021-01.csv

ENTRYPOINT [ "python", "ingest_data.py" ]
