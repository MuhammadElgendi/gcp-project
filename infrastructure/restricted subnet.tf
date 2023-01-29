resource "google_compute_subnetwork" "restricted-subnet" {
  name                     = "restricted-subnet"
  ip_cidr_range            = "10.0.2.0/24"
  region                   = var.region
  network                  = google_compute_network.final-vpc.id
  private_ip_google_access = false
  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.2.2.0/24"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.3.2.0/24"
  }
}




