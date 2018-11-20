provider "google" {
  project = "infra-222321"
  region = "australia-southeast1"
}
resource "google_compute_instance" "app" {
  name		= "reddit-app"
  machine_type	= "g1-small"
  zone 		= "australia-southeast1-a"
  #set boot disk
  boot_disk {
    initialize_params {
    image = "reddit-base-1542312925"
    }
  }
  metadata {
    sshKeys = "aliaksandr:${file("~/.ssh/id_rsa.pub")}"
  }
  tags = ["reddit-app"]
  #set network interface
  network_interface {
    #the net, which will connecting with this interface
    network = "default"
    #to use ephemeral IP for the acces from Internet
    access_config {}
    }
  connection {
    type	= "ssh"
    user 	= "aliaksandr"
    agent	= false
    private_key = "${file("~/.ssh/id_rsa")}"
  }
  provisioner "file" {
    source = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
  script = "files/deploy.sh"
  }
}

  resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  #the name of network where is rules work
  network = "default"
  #which access to allow
  allow {
   protocol 	= "tcp"
    ports 	= ["9292"]
  }
  #allow access for next addresses
  source_ranges = ["0.0.0.0/0"]
  #rule can be applied to instance with tag
  target_tags = ["reddit-app"]
}
