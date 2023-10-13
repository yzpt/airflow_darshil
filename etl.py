import pandas as pd
import json
from datetime import datetime
from google.cloud import storage
from google.cloud import bigquery
import os
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Set up environment variables
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'key.json'

# Set up GCP clients
storage_client = storage.Client()
bq_client = bigquery.Client()

# Set up GCP bucket and blob
bucket = storage_client.get_bucket('airflow-darhsil-bucket')

