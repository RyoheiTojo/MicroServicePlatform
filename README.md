# scoreHub

## Requirement

macOS
```
brew install terraform-inventory
brew install terraform
brew install ansible
```

## Usage
```
$ export TF_VAR_access_key=<AWS Access Key>
$ export TF_VAR_secret_key=<AWS Secret Key>
$ export ANSIBLE_HOST_KEY_CHECKING=False
$ ansible-playbook --inventory-file=./terraform/ec2.sh playbooks/terraform.yml -u ec2-user
```
