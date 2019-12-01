#!/bin/bash

tf_dir="`dirname $0`"
tf_file="`dirname $0`/terraform.tfstate"

echo ${tf_file}

if [ ! -e ${tf_file} ]; then
  echo '{"all": {"hosts": ["localhost"]}}'
  exit 0
fi

terraform-inventory --list ${tf_dir} 2> /dev/null

if [ $? -gt 0 ]; then
  echo '{"all": {"hosts": ["localhost"]}}'
fi
