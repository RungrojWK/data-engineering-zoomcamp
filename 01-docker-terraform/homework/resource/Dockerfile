FROM python:3.12.8

RUN apt-get update && apt-get install -y wget
RUN pip install pandas sqlalchemy psycopg2-binary

WORKDIR /app
COPY ingest_data.py ingest_data.py

ENTRYPOINT [ "python", "ingest_data.py" ]
