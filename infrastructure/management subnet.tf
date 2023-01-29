resource "google_compute_subnetwork" "management_subnet" {
  name                     = "management-subnet"
  ip_cidr_range            = "10.0.1.0/24"
  region                   = var.region
  network                  = google_compute_network.final-vpc.id
  private_ip_google_access = false
}
#################################################################
# CLOUD-NAT 
resource "google_compute_route" "egress_internet" {
  name             = "egress-internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.final-vpc.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = var.region
  network = google_compute_network.final-vpc.name
}

resource "google_compute_router_nat" "nat_router" {
  name                               = "nat-router"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = false
    filter = "ERRORS_ONLY"
  }
}


#################################################################
resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  depends_on = [
    google_container_cluster.final-cluster
   , google_container_node_pool.node-pool
  ]
  
  metadata_startup_script = "${file("./script.sh")}"

  service_account {
    email = google_service_account.final-sa.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform" ]
  }
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size = 80
    }
  }
 
  network_interface {
    network =  google_compute_network.final-vpc.id
    subnetwork = google_compute_subnetwork.management_subnet.id
  }

}


