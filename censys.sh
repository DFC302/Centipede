#!/bin/bash

# This script is similar to censysIP.sh but instead grabs the IP, port, method, and protocol used.

TOKEN=#PLACE TOKEN HERE
PAGE=100 # number of pages to return results on

while read domain ; do
        curl -X 'GET' -s \
                'https://search.censys.io/api/v2/hosts/search?q=Relias&per_page=50&virtual_hosts=EXCLUDE' \
                -H 'accept: application/json' -H "Authorization: Basic ${TOKEN}" | jq '.result.hits[] | "\(.ip) \(.services[].port) \(.services[].service_name) \(.services[].transport_protocol)"' | sed 's/"//g'
done
