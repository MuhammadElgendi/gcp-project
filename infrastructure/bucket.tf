# CREATING BUCKET STORAGE
resource "google_storage_bucket" "gcp-bucket-project" {
  name          = "gcp-bucket-project"
  location      = "US"
  force_destroy = true

}

# UPLOADING YAML FILES TO THE BUCKET
resource "google_storage_bucket_object" "app" {
  name   = "app.yaml"
  source = "/home/gendi/Downloads/projct/yaml/app.yaml"
  bucket = var.bucket
}
resource "google_storage_bucket_object" "lb" {
  name   = "lb.yaml"
  source = "/home/gendi/Downloads/projct/yaml/lb.yaml"
  bucket = var.bucket
}
resource "google_storage_bucket_object" "redis" {
  name   = "redis.yaml"
  source = "/home/gendi/Downloads/projct/yaml/redis.yaml"
  bucket = var.bucket
}
resource "google_storage_bucket_object" "redis-service" {
  name   = "redis-service.yaml"
  source = "/home/gendi/Downloads/projct/yaml/redis-service.yaml"
  bucket = var.bucket
}
