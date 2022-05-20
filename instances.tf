resource "google_compute_instance" "kubernetes-node-master" {
  name         = "kubernetes-master"
  project      = var.project
  machine_type = var.machine_type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-pro-cloud/ubuntu-pro-1804-lts"
      size  = "10"
      type  = "pd-standard"

    }
  }

  network_interface {
    network    = google_compute_network.cluster_network.id
    subnetwork = google_compute_subnetwork.cluster-subnetwork.id
    network_ip = ""


    #     access_config {
    #       nat_ip = ""
    #       network_tier = "STANDARD"
    #     }
  }

  metadata_startup_script = file("./startup-script-master.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "kubernetes-nodes-slaves" {
  name         = "kubernetes-slave-${count.index}"
  count        = 2
  project      = var.project
  machine_type = var.machine_type
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-pro-cloud/ubuntu-pro-1804-lts"
      size  = "10"
      type  = "pd-standard"

    }
  }

  network_interface {
    network    = google_compute_network.cluster_network.id
    subnetwork = google_compute_subnetwork.cluster-subnetwork.id
    network_ip = ""


    #     access_config {
    #       nat_ip = ""
    #       network_tier = "STANDARD"
    #     }
  }

  metadata_startup_script = file("./startup-script-slave.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}

