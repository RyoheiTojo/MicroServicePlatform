# scoreHub

## Requirement

macOS
```
$ brew install terraform-inventory
$ brew install terraform
$ brew install ansible
$ ssh-keygen -t rsa
```

## Usage
build
```
$ export TF_VAR_access_key=<AWS Access Key>
$ export TF_VAR_secret_key=<AWS Secret Key>
$ export ANSIBLE_HOST_KEY_CHECKING=False
$ export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
$ ansible-playbook --inventory-file=./terraform/ec2.sh playbooks/provision/terraform.yml -u ec2-user
```

destroy
```
$ ansible-playbook playbooks/provision/destroy.yml
```
