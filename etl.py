import pandas as pd
import json
from datetime import datetime
from google.cloud import storage
from google.cloud import bigquery
import os
import logging
import requests

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Set up environment variables
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "airflow-darshil-sa.json"

# Read in the data from the API
logger.info('Reading data from API')
url = 'https://opendata.lillemetropole.fr/api/records/1.0/search/?dataset=vlille-realtime&rows=300'
response = requests.get(url)
data = response.json()

print(data)