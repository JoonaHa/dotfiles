#!/usr/bin/env bash

dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
touch ${dir}/lg_renew.log

if [ ! -f "${dir}/.token" ]
then
    echo "$(date --iso-8601=seconds): Can not find token file ${dir}/.token" | tee ${dir}/lg_renew.log
    exit 1 
fi

token=$(cat "${dir}/.token")

url="https://developer.lge.com/secure/ResetDevModeSession.dev?sessionToken=${token}"
return=$(curl -L "$url")
echo "$(date --iso-8601=seconds): $return" | tee ${dir}/lg_renew.log
