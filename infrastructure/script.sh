#!/bin/bash
sudo apt install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
sudo apt-get update && sudo apt-get install -y google-cloud-cli
sudo apt-get install kubectl
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
sudo gcloud container clusters get-credentials final-cluster --zone us-central1-c --project gcp-project-376206
sudo gsutil cp -r gs://gcp-bucket-project /home/muhammedshaaban97/
sudo kubectl create -Rf /home/muhammedshaaban97/

