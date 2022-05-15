datacenter = "dc1"
bind_addr = "172.16.1.23"
data_dir = "/opt/nomad/"

advertise {
  # Defaults to the first private IP address.
  http = "172.16.1.23"
  rpc  = "172.16.1.23"
  serf = "172.16.1.23" # non-default ports may be specified
}

client {
        enabled = true
	network_interface = "vxlan100"
	servers = ["172.16.2.9"]
	meta {
		"outname" = "vmname.100do.se"
                "master" = "0"
	}
}

consul {
         client_service_name = "nomad-client"
         auto_advertise = true
         client_auto_join = true
}