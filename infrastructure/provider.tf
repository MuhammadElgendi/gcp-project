terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
}
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
}
provider "docker" {
  host = "unix:///var/run/docker.sock"
}
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}


