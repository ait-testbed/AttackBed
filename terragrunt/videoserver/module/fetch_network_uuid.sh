#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract "network_name" arguments from the input into
# NETWORK_NAME and shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "NETWORK_NAME=\(.network_name)"')"

# data fetching
UUID=$(openstack network list --project "$OS_PROJECT_ID" --name "$NETWORK_NAME" -f value -c ID)

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg uuid "$UUID" '{"uuid":$uuid}'