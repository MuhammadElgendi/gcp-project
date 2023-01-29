resource "google_container_registry" "gcr" {
  project  = var.project
  location = "EU"
}

# resource "google_storage_bucket_iam_member" "storage-get" {
#   bucket = google_container_registry.gcr.id
#   role   = "roles/storage.buckets.get
#   "
#   member = "serviceAccount:${google_service_account.final-sa.email}"
# }
resource "google_storage_bucket_iam_member" "bucket_A" {
  bucket = google_container_registry.gcr.id
  role   = "roles/storage.objectCreator"
  member ="serviceAccount:${google_service_account.final-sa.email}"
  depends_on = [google_container_registry.gcr]
}