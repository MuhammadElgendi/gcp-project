resource "google_container_cluster" "final-cluster" {
  name                     = "final-cluster"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.final-vpc.self_link
  subnetwork               = google_compute_subnetwork.restricted-subnet.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
   master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.1.0/24"
      display_name = "managment-Subnet-cidr-range"
    }
  }
  addons_config {
    http_load_balancing {
      disabled = true
    }
     horizontal_pod_autoscaling {
      disabled = false
    }
  }
   release_channel {
    channel = "REGULAR"
  }
    node_config {
  service_account = google_service_account.final-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  node_locations = [
    "us-central1-b"
  ]
  workload_identity_config {
    workload_pool = "gcp-project-376206.svc.id.goog"
  }


  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"

  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"

  }
}

# NODE POOL
resource "google_container_node_pool" "node-pool" {
  name       = "general"
  cluster    = google_container_cluster.final-cluster.id
  node_count = 1
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    service_account = google_service_account.final-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

