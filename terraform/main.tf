// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("CREDENTIALS_FILE.json")}"
 project     = "FlowFactor"
 region      = "europe-west2" #London
}

/*
VPC network
*/
resource "google_compute_network" "vpc_network" {
  name = "vpc_network"
  description = "test vpc created by hans"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet_1"
  description = "test subnet created by hans"
  ip_cidr_range = "192.168.10.0/24"
  region        = "europe-west2"
  network       = "${google_compute_network.vpc_network.self_link}"
}





/*
Instance
*/
resource "google_compute_instance" "instance" {
  name = "instance"
  machine_type = "n1-standard-1	"
  zone = "europe-west2-a"
  description = "test instance created by hans"

  # image
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20190320"
    }
  }

  # vpc
  network_interface {
    network = "subnet_1"
  }

  # public ip
  access_config{

  }

  # idk
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

}
