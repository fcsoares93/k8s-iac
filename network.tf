resource "google_compute_network" "cluster_network" {
  name                    = "cluster-network"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cluster-subnetwork" {
  name          = "cluster-subnetwork"
  project       = var.project
  region        = var.region
  ip_cidr_range = "10.50.0.0/20"
  network       = google_compute_network.cluster_network.name

}

resource "google_compute_router" "cluster-router" {
  name    = "cluster-router"
  project = var.project
  region  = var.region
  network = google_compute_network.cluster_network.name
  bgp {
    asn            = 64514
    advertise_mode = "DEFAULT"
  }
}

resource "google_compute_router_nat" "cluster-nat" {
  name                               = "cluster-router-nat"
  project                            = var.project
  region                             = var.region
  router                             = google_compute_router.cluster-router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

resource "google_compute_firewall" "internal-firewall" {
  name    = "cluster-firewall"
  project = var.project
  network = google_compute_network.cluster_network.name

  allow {
    protocol = "all"
  }

  source_ranges = [google_compute_subnetwork.cluster-subnetwork.ip_cidr_range]

}

resource "google_compute_firewall" "iap-firewall" {
  name    = "iap-firewall"
  project = var.project
  network = google_compute_network.cluster_network.name

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20", ]

}
