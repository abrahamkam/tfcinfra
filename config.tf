provider "google" {
  project = "gyee-365020"
  region  = "europe-north1"
  zone = "europe-north1-a"
}

resource "google_compute_network" "primary_vpc" {
  name = "pvpc"
}

resource "google_storage_bucket" "terrafirma_storage" {
  name          = "terrafirma_storage"
  location      = "europe-north1"
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_compute_instance" "terrafirma" {
  name         = "terrafirma"
  machine_type = "e2-highmem-2"

  tags = ["tfc", "worker"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }


  network_interface {
    network = "pvpc"

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["cloud-platform"]
  }
  
}
