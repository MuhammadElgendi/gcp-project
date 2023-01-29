resource "google_compute_network" "final-vpc" {
  project                 = var.project
  name                    = "final-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "final-task-firewall" {
  name    = "final-task-firewall"
  network = google_compute_network.final-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
#                 service_account                #
##################################################
resource "google_service_account" "final-sa" {
  account_id = "project-service-account"
  project = var.project
  
  
}
# IAM CUSTOME ROLE
resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "myCustomRole"
  title       = "my custom role"
  description = "this is a custom role for the project"
  permissions = ["resourcemanager.projects.get", "storage.buckets.get", "storage.buckets.list" , 
  "storage.objects.get" , "storage.objects.list" , "container.deployments.get" , 
  "container.deployments.create" , "container.deployments.list" , "container.services.list" , 
  "container.services.get" , "container.services.create" , "container.clusters.list" , 
  "container.clusters.getCredentials" , "container.clusters.get" , 
  "container.pods.list" ,"container.nodes.list"]
}
# PROJECT IAM BINDING 01
# GIVING ROLE.STORAGE ADMIN FOR MY CUSTOME SA 
resource "google_project_iam_binding" "project-SA-iam01" {
  project = var.project
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.final-sa.email}"
  ]
}

# PROJECT IAM BINDING 02
resource "google_project_iam_binding" "project-SA-iam02" {
  project = var.project
  role    = "projects/${google_service_account.final-sa.project}/roles/${google_project_iam_custom_role.my-custom-role.role_id}"
  members = [
    "serviceAccount:${google_service_account.final-sa.email}"
  ]
}




