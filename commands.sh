#venv
python -m venv venv
.\venv\Scripts\activate

pip install pandas
pip install google-cloud-storage
pip install google-cloud-bigquery

# new gcp project
gcloud projects create airflow-darshil
gcloud config set project airflow-darshil

# create service account
gcloud iam service-accounts create airflow-darshil-sa --display-name "airflow-darshil-sa"
gcloud iam service-accounts list
# airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com

# create key
gcloud iam service-accounts keys create airflow-darshil-sa.json --iam-account='airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com' --key-file-type=json > key.json

# grant access to service account
gcloud projects add-iam-policy-binding airflow-darshil --member='serviceAccount:airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com' --role='roles/owner' --project=airflow-darshil

# billing account
gcloud billing accounts list
# 012A63-E71939-70F754  Mon compte de facturation  True
gcloud billing projects link airflow-darshil --billing-account=012A63-E71939-70F754

# create bucket
gsutil mb -p airflow-darshil gs://airflow-darshil-bucket

# enable compute engine api
gcloud services enable compute.googleapis.com

# set roles for compute engine api
gcloud projects add-iam-policy-binding airflow-darshil --member='serviceAccount:airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com' --role='roles/compute.admin' --project=airflow-darshil


# compute engine instance-4 created on GUI
gcloud compute instances describe instance-4 --zone=us-west4-b --project=airflow-darshil
# natIP: 34.16.148.140

# ssh into vm
gcloud compute ssh instance-4 --zone=us-west4-b --project=airflow-darshil

# -- ssh:
sudo apt-get update
sudo apt-get install python3-pip -y
sudo pip install apache-airflow
sudo pip install pandas
sudo pip install google-cloud-storage

airflow standalone
# admin / 6R4sdN5wRDDZvTF7

# chrome > 34.16.148.140:8080
# ===============           ok !       =================

# delete vm
gcloud compute instances delete instance-4 --zone=us-west4-b --project=airflow-darshil -q