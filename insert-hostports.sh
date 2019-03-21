#!/usr/bin/env bash
set -eou pipefail

# adds or updates the json for PortMappings to enforce only welder nic card
# is permitted on localhost and welder nic card Host IP address

if [[ $# -ne 2 || ! -f "$1" ]]
  then
    printf "Two arguments required - or file name does not exist\n"
    printf "first argument is json file second is the IP address of NIC card\n"
    exit 1
fi

WELDER_IP=$2

EXP1='.modulesContent."$edgeAgent"."properties.desired".modules.mosquitto.settings.createOptions.HostConfig.PortBindings|= '
EXP1+='.+ { "1883/tcp": [ { "HostPort": "1883", '
EXP1+="\"HostIp\": \"${WELDER_IP}\"},{ \"HostPort\": \"1883\", \"HostIp\": \"127.0.0.1\"}] }"

cat $1 | jq "${EXP1}" -r

