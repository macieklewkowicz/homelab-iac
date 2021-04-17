provider "matchbox" {
  endpoint    = "192.168.0.100:4081"
  client_cert = file("~/.matchbox/client.crt")
  client_key  = file("~/.matchbox/client.key")
  ca          = file("~/.matchbox/ca.crt")
}

provider "ct" {}

terraform {
  required_providers {
    ct = {
      source  = "poseidon/ct"
      version = "0.6.1"
    }
    matchbox = {
      source = "poseidon/matchbox"
      version = "0.4.1"
    }
  }
}

