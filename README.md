# gcp-project
# GCP-Final

###  :Build image from the app code by docker file by:

  * $ docker build -t gcp-python .
  * $ docker tag iti-app eu.gcr.io/gcp-project-376206/iti-app
  * $ docker push eu.gcr.io/gcp-project-376206/iti-app:latest

### Pull Another Redis Image From Docker Hub Then Push It To GCR :

  * $ docker pull redis
  * $ docker tag redis eu.gcr.io/gcp-project-376206/redis
  * $ docker push eu.gcr.io/gcp-project-376206/redis

### Using Script.sh File When The VM Created Will Do : 

  * Install gcloud 
  * Install kubectl
  * Install gcloud plugin
  * Connect To Kubernetes Cluster
  * Copy yaml Files From Bucket To VM
  * Apply All yaml Files

### Permission To Access Private Container Registry :

  * It Added To The Code


### For Apply The Terraform Code :

  * $ terraform init
  * $ terraform plan 
  * $ terraform apply

