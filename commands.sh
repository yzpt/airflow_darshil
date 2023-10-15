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
gcloud iam service-accounts keys create airflow-darshil-sa.json --iam-account='airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com' --key-file-type=json

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


# create vm
$PROJECT_ID="airflow-darshil"
$ZONE="europe-west1-b"
gcloud compute instances create my-vm2 --project=$PROJECT_ID --zone=$ZONE --machine-type=e2-standard-8 --network-tier=PREMIUM --stack-type=IPV4_ONLY --subnet=default --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=airflow-darshil-sa@airflow-darshil.iam.gserviceaccount.com --boot-disk-auto-delete --boot-disk-type=pd-standard --boot-disk-device-name=instance-1 --image=projects/debian-cloud/global/images/debian-11-bullseye-v20231010 --image-project=rw --boot-disk-size=10 --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any 

# add tags
gcloud compute instances add-tags my-vm2 --tags airflow-webserver --zone=$ZONE --project=$PROJECT_ID

# allow connexion on airflow port 8080
gcloud compute firewall-rules create airflow-webserver --allow tcp:8080 --target-tags airflow-webserver --project=$PROJECT_ID --description="Allow http traffic on port 8080" --direction=INGRESS --priority=1000 --network=default --source-ranges='0.0.0.0/0' --target-tags=airflow-webserver 

# ssh
gcloud compute ssh my-vm2 --zone=$ZONE --project=$PROJECT_ID
# vm commands:
sudo apt-get update
sudo apt-get install python3-pip -y
sudo pip install apache-airflow
sudo pip install pandas
sudo pip install google-cloud-storage
airflow standalone
# admin / HPhrXP8HCuuYCNUp

# infos
gcloud compute instances describe my-vm2 --zone=$ZONE --project=$PROJECT_ID
# natIP: 35.205.225.201

# chrome 
# url: 35.205.225.201:8080
# admin / HPhrXP8HCuuYCNUp

