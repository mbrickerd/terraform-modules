locals {
  /*  For more information on configuring private Google access see:
  https://cloud.google.com/vpc/docs/configure-private-google-access#config  */
  quadzero_cidr                     = "0.0.0.0/0"
  vpc_private_google_access_cidr    = "199.36.153.8/30"
  vpc_restricted_google_access_cidr = "199.36.153.4/30"
  vpc_iap_tcp_forwarding_cidr       = "35.235.240.0/20"

  dns_zones = {
    pkg-dev = {
      dns = "pkg.dev."
      ips = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
    }
    gcr-io = {
      dns = "gcr.io."
      ips = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
    }
    googleapis = {
      dns = "googleapis.com."
      ips = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
    }
  }
}
