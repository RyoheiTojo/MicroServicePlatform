#####################################
# TerraForm Variable Settings
#####################################
region = "ap-northeast-1"

images = {
  redhat8 = "ami-09f31cc5d5eecca1a"
  amazon_linux1 = "ami-0ab3e16f9c414dee7"
  amazon_linux2 = "ami-068a6cefc24c301d2"
}

server_count = {
  manager_server = 3
  application_server = 2
}

key_name = "sshkey_for_ansible"

public_key_path = "~/.ssh/id_rsa.pub"

#Segment Settings
root_segment = "10.10.0.0/16"
public_segment = "10.10.10.0/24"
private_segment = "10.10.11.0/24"
