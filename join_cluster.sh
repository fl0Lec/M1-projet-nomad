#! /bin/bash

ipa=$(ip -4 addr show dev vxlan100 | grep "/16 brd" | cut -d 't' -f 2 | cut -d ' ' -f 2 | cut -d '/' -f 1)

echo "datacenter = \"dc1\" 
data_dir = \"/opt/consul\" 
log_level = \"DEBUG\" 
server = false 
bind_addr = \"${ipa}\" 
advertise_addr = \"${ipa}\" 
retry_join = [\"172.16.2.9\"] 
ports { 
  grpc = 8502 
} 
connect { 
  enabled = true 
}" > /etc/consul.d/consul.hcl

echo "datacenter = \"dc1\" 
bind_addr = \"${ipa}\" 
data_dir = \"/opt/nomad/\" 

advertise { 
  # Defaults to the first private IP address. 
  http = \"${ipa}\" 
  rpc  = \"${ipa}\" 
  serf = \"${ipa}\" # non-default ports may be specified 
} 

client { 
        enabled = true 
	network_interface = \"vxlan100\" 
	servers = [\"172.16.2.9\"] 
	meta { 
		\"outname\" = \"$(hostname | sed s/"internal."//)\" 
        \"master\" = \"0\" 
	} 
} 

consul { 
         client_service_name = \"nomad-client\" 
         auto_advertise = true 
         client_auto_join = true 
}" > /etc/nomad.d/nomad.hcl

systemctl restart consul.service
systemctl restart nomad.service