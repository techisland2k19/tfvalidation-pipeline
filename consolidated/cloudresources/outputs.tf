
output "vpc_name" {
  value       = "${google_compute_network.default.name}"
  description = "Name of the created VPC."
}


output "gateway_ipv4" {
  value       = "${google_compute_network.default.gateway_ipv4}"
  description = "The IPv4 address of the gateway"
}



output "subnetworks_self_links" {
  value       = ["${google_compute_subnetwork.default.*.self_link}"]
  description = "the list of subnetworks which belong to the network"
}

output "firewal_self_link" {
  description = "The URI of the created resource"
  value       = "${google_compute_firewall.new-firewall.name}"
}

output "Bucket_name" {
  description = "Bucket names."
  value       = module.cloud_storage.names
}
