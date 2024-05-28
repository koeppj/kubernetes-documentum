#!/bin/bash

#
# Get project root.
#
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
#
# Environment Variable Setups.  
#
source $SCRIPT_DIR/../.env
export manifests_dir=$SCRIPT_DIR/../manifests

export database_user_encoded=$(echo ${database_user} | tr -d '[:space:]' | base64)
export database_user_password_encoded=$(echo ${database_user_password} | tr -d '[:space:]' | base64)
export dm_docbase_owner_password_encoded=$(echo ${dm_docbase_owner_password} | tr -d '[:space:]' | base64)
export dm_database_admin_password_encoded=$(echo ${dm_database_admin_password} | tr -d '[:space:]' | base64)
export dm_database_owner_password_encoded=$(echo ${dm_database_owner_password} | tr -d '[:space:]' | base64)
export dm_gr_registry_password_encoded=$(echo ${dm_gr_registry_password} | tr -d '[:space:]' | base64)

envsubst < ${manifests_dir}/database.yaml | microk8s kubectl apply -f -
envsubst < ${manifests_dir}/content-server.yaml | microk8s kubectl apply -f -
