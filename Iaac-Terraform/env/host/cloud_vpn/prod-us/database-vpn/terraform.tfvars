project_id = "<host-project-id>"
region     = "us-central1"

vpn_ha = {
  "prod-01-us-central1-cloud-vpn" = {
    project_id = "<host-project-id>"
    region     = "us-central1"
    vpc_name   = "prod-main-vpc"
    router_asn = 65000

    peer_external_gateway = {
      redundancy_type = "FOUR_IPS_REDUNDANCY"
      interfaces = [{
        id         = 0
        ip_address = ""
        },
        {
          id         = 1
          ip_address = ""
        },
        {
          id         = 2
          ip_address = ""
        },
        {
          id         = 3
          ip_address = ""
      }]
    }

    tunnels = {
      prod-01-us-central1-vpn-tunnel-0 = {
        bgp_peer = {
          address = "" # add bgp_peer address here
          asn     = 64512
        }
        bgp_peer_options = {
          advertise_ip_ranges = {
            "10.2.124.0/22" = "prod-redis-01-psa"
            "10.2.120.0/22" = "prod-sql-01-psa"
          }
          advertise_mode = "CUSTOM"
          advertise_groups = ["ALL_SUBNETS"]
        }
        bgp_session_range               = "" # add bgp_session_range here
        ike_version                     = 2
        vpn_gateway_interface           = 0
        peer_external_gateway_interface = 0
        shared_secret                   = "" #secret_key_phrase2
      }
      prod-01-us-central1-vpn-tunnel-1 = {
        bgp_peer = {
          address = "" # add bgp_peer address here
          asn     = 64512
        }
        bgp_peer_options = {
          advertise_ip_ranges = {
            "10.2.124.0/22" = "prod-redis-01-psa"
            "10.2.120.0/22" = "prod-sql-01-psa"
          }
          advertise_mode = "CUSTOM"
          advertise_groups = ["ALL_SUBNETS"]
        }
        bgp_session_range               = "" # add bgp_session_range here
        ike_version                     = 2
        vpn_gateway_interface           = 0
        peer_external_gateway_interface = 1
        shared_secret                   = "" #secret_key_phrase3
      }
      prod-01-us-central1-vpn-tunnel-2 = {
        bgp_peer = {
          address = "" # add bgp_peer address here
          asn     = 64512
        }
        bgp_peer_options = {
          advertise_ip_ranges = {
            "10.2.124.0/22" = "prod-redis-01-psa"
            "10.2.120.0/22" = "prod-sql-01-psa"
          }
          advertise_mode = "CUSTOM"
          advertise_groups = ["ALL_SUBNETS"]
        }
        bgp_session_range               = "" # add bgp_session_range here
        ike_version                     = 2
        vpn_gateway_interface           = 1
        peer_external_gateway_interface = 2
        shared_secret                   = "" #secret_key_phrase0

      }
      prod-01-us-central1-vpn-tunnel-3 = {
        bgp_peer = {
          address = "" # add bgp_peer address here
          asn     = 64512
        }
        bgp_peer_options = {
          advertise_ip_ranges = {
            "10.2.124.0/22" = "prod-redis-01-psa"
            "10.2.120.0/22" = "prod-sql-01-psa"
          }
          advertise_mode = "CUSTOM"
          advertise_groups = ["ALL_SUBNETS"]
        }
        bgp_session_range               = "" # add bgp_session_range here
        ike_version                     = 2
        vpn_gateway_interface           = 1
        peer_external_gateway_interface = 3
        shared_secret                   = "" #secret_key_phrase1
      }
    }
  },
}
