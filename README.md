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
$ ansible-playbook --inventory-file=./terraform/ec2.sh playbooks/terraform.yml -u ec2-user
```
