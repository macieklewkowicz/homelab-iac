module "mercury" {
  source = "git::https://github.com/poseidon/typhoon//bare-metal/container-linux/kubernetes?ref=v1.19.3"

  # bare-metal
  cluster_name            = "smol"
  matchbox_http_endpoint  = "http://192.168.0.100:4080"
  os_channel              = "flatcar-stable"
  os_version              = "2605.12.0"
  download_protocol       = "http"
  install_disk            = "/dev/vda"

  kernel_args             = ["flatcar.autologin"]

  # configuration
  k8s_domain_name    = "controller.k8s.lan"
  ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrg2lPE8VitqBMbmAf3GIYj31CHvtqGpsbd3ksVTj+w7IYWFxaAOGq7xJt1Xag/9+krHxPB92U/3S9J2QVXrgUzd0OoKEdGYoZI5dR/dUdVomjYYSYj7wPpbCdMlbopdykcI4TP5zaygDk48S9Ma8yP1TmBmsZddPVpJ1adAkfBMKsNZnInYZ8M8fnA305HCIqYrlrG6hoBr5DAs54xXOWywhCvb6QoxUOPLwxrzZPOkzrcXGAFecltrENqdgoJutMZZTlHNbecElfzPPmhSvaHT5+b0nkIeII0KMGZgZtJyZE3ECc1fcIWzUuAFzx8/GXE/2Y1F9Nyo8O3rpCfWlKaHGf0R9fYeFAV023pWzTBPlnL7xuhNTNhppi1eggAzKcMDXXFYqPDP+NzeYesEd+NNlzX2vVb0wX3rt5MJa/a8t4E0NHPwvnJe60dMuJnylJKoWmMca3ESehYvbRk34dfdYo5GljxjBzzNgKyFD/tHXJ5BRrgkMrtYFzFTY+7caZ1OELpWxos4Mlm/CCFySYkfNJoIEjxMLWm7NeOTf4sfUAMTwQjVbZ9eXbeuro/DO+aYHXXK9dz0+hST7p8nb3tl9ZzmoJFQxa1E4YVI+nrlIYdS7zswCiMWRJscLYsznfwvqZskeMszgpej3TD4eqS/2R8pkKsGRS7dPwqBeH6Q== maciej@lewkowi.cz"

  # machines
  controllers = [
    {
      name   = "controller1"
      mac    = "76:69:72:74:01:01"
      domain = "controller1.k8s.lan"
    }
  ]

  workers = [
    {
      name   = "worker1"
      mac    = "76:69:72:74:02:01"
      domain = "worker1.k8s.lan"
    },
    {
      name   = "worker2"
      mac    = "76:69:72:74:02:02"
      domain = "worker2.k8s.lan"
    },
    {
      name   = "worker3"
      mac    = "76:69:72:74:02:03"
      domain = "worker3.k8s.lan"
    }
  ]

  # set to http only if you cannot chainload to iPXE firmware with https support
  # download_protocol = "http" 
}

resource "local_file" "kubeconfig-mercury" {
  content  = module.mercury.kubeconfig-admin
  filename = "assets/config"
}
