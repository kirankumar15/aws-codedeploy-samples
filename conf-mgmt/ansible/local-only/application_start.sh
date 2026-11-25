#!/bin/bash

# Deploy hooks are run via absolute path, so taking dirname of this script will give us the path to
# our deploy_hooks directory.
. $(dirname $0)/common_variables.sh

# The application DB password is not stored in this repository. Use
# LAMP_DB_PASSWORD from the environment when it is set; otherwise generate a
# random one for this deployment. The playbook sets it on the MySQL user and
# writes it to /etc/lamp_simple/db.ini (mode 0640) on this host.
if [ -z "$LAMP_DB_PASSWORD" ]; then
  LAMP_DB_PASSWORD=$(openssl rand -hex 24) || exit 1
fi
export LAMP_DB_PASSWORD

ansible-playbook $DESTINATION_PATH/lamp_simple/site.yml -i $DESTINATION_PATH/lamp_simple/hosts --connection=local 
