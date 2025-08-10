# ------------------------------------------------------------------
# Terraform for GCP Private DNS Hosted Zone creation on GCP Cloud DNS.
# ------------------------------------------------------------------

# Create Private DNS Zone for Dev Environment
data "google_compute_network" "dev-network" {
  name    = var.vpc_name
}

resource "google_dns_managed_zone" "private-zone" {
  name        = "dev-staging-private-dns-zone"
  dns_name    = "com."
  description = "sample Staging Private DNS Zone"
  
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = data.google_compute_network.dev-network.id
    }
  }
}

# ------------------------------------------------------------------
# Terraform for GCP CloudSQL Private DNS Records creation on GCP Cloud DNS.
# ------------------------------------------------------------------

# Create A Record for CloudSQL MySQL Database Instance
data "google_sql_database_instance" "mysql_instance" {
  project = var.svc_project_id
  name    = "dev-us-central1-mysql-01"
}

resource "google_dns_record_set" "mysql_dns_record" {
  name = "mysql-db.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 5
  managed_zone = google_dns_managed_zone.private-zone.name
  rrdatas = [data.google_sql_database_instance.mysql_instance.ip_address.0.ip_address]
}

# Create A Record for CloudSQL PostgreSQL Database Instance
data "google_sql_database_instance" "postgres_instance" {
  project = var.svc_project_id
  name    = "dev-us-central1-postgresql-01"
}

resource "google_dns_record_set" "postgres_dns_record" {
  name = "postgres-db.${google_dns_managed_zone.private-zone.dns_name}"
  type = "A"
  ttl  = 5
  managed_zone = google_dns_managed_zone.private-zone.name
  rrdatas = [data.google_sql_database_instance.postgres_instance.ip_address.0.ip_address]
}

# Create A Records for MemoryStore Redis Instances
resource "google_dns_record_set" "redis_dns_records" {
  for_each     = var.redis_dns_config
  name         = each.value.redis_dns_name
  type         = "A"
  ttl          = 5
  managed_zone = google_dns_managed_zone.private-zone.name
  rrdatas      = [each.value.redis_ipv4_address]
}