provider "google" {
  credentials = "${file("/workspace/key.json")}"
  project = "p-02-08-19-gcp-lab-admin4"
  zone= "us-east1-c"
}


resource "google_compute_network" "default" {
    name                    = "${var.name}"
    auto_create_subnetworks = "${var.auto_create_subnetworks}"
    routing_mode            = "${var.routing_mode}"
}

 resource "google_compute_subnetwork" "default" {

      count         = "${var.auto_create_subnetworks == "false" ? length(var.subnetworks) : 0}" 
      name          = "${lookup(var.subnetworks[count.index], "subnetname")}" # mandatory, as name setting on region name for ease from subnetwork variable
      #project       = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
      ip_cidr_range = "${lookup(var.subnetworks[count.index], "cidr")}"  # mandatory, as cidr setting on region after getting from subnetwork variable
      region        = "${lookup(var.subnetworks[count.index], "region")}" # as region setting in subnetwork variable
      network       = "${google_compute_network.default.self_link}" # mandatory

      #enable_flow_logs          = "${lookup(var.subnetworks[count.index], "enable_flow_logs", "false")}"
      #log_config {
   # aggregation_interval = "INTERVAL_10_MIN"
    #flow_sampling        = 0.5
    #metadata             = "INCLUDE_ALL_METADATA"
  #} 
     private_ip_google_access  = "${lookup(var.subnetworks[count.index], "private_ip_google_access", "false")}" 

      secondary_ip_range = "${var.secondary_ranges[lookup(var.subnetworks[count.index], "region")]}"
  }


resource "google_compute_firewall" "new-firewall" {
  name    = "${google_compute_network.default.name}-firewall-${var.fw_name}"
  network = "${google_compute_network.default.name}"
  project = "${var.project}"

  allow {
    protocol = "${var.protocol}"
    ports    = "${var.ports}"
  }

  target_tags   = ["${google_compute_network.default.name}-firewall-${var.fw_name}"]
  source_ranges = "${var.source_ranges}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "test-ep0233"
    project = "${var.project}"
  machine_type = "f1-micro"
   zone         = "us-east1-c"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.default.self_link}"
    subnetwork = "${google_compute_subnetwork.default.*.name[0]}"
  subnetwork_project = "p-02-08-19-gcp-lab-admin4" 
   access_config  {
    }
  }
}

resource "google_compute_instance" "vm_instance08" {
  name         = "test-ep0224"
  machine_type = "f1-micro"
zone         = "us-east1-c"  
project = "${var.project}"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.default.self_link}"
  subnetwork = "${google_compute_subnetwork.default.*.name[0]}"   
  subnetwork_project = "p-02-08-19-gcp-lab-admin4" 
access_config  {
    }
  }
}



resource "google_project_iam_binding" "iam_based_roles" {
  project = "${var.project}"
  role    = "roles/editor"

  members = [
    "user:zubair.munir17@gmail.com",
    "user:learningtech2k19@gmail.com",
  ]
}

resource "google_sql_database" "test_db" {
  name     = "test-ep0234-db"
  instance = google_sql_database_instance.test_ins.name
}

resource "google_sql_database_instance" "test_ins" {
  name   = "test-ep0234-ins"
  region = "us-central"
  settings {
    tier = "D0"
  }
}

  
module "cloud_storage" {
  source               = "terraform-google-modules/cloud-storage/google"
  project_id            = "p-02-08-19-gcp-lab-admin4"
  names                = ["${var.project}-vli08"]
  prefix               = "b01"
  location             = "US"
  bucket_policy_only   = {"${var.project}-vli08" = false }
  force_destroy        = {"${var.project}-vli08" = true }
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "${module.cloud_storage.name}"
  role        = "roles/storage.objectViewer"

  members = [
    "allUsers",
    "allAuthenticatedUsers",
  ]
}


 resource "google_storage_bucket" "bk_validate" {
  name     = "bkt-validator-023"
  location = "EU"
  project = "p-02-08-19-gcp-lab-admin4"
  logging {
  log_bucket = "b01-us-p-02-08-19-gcp-lab-admin4-vli08"
        }
}
