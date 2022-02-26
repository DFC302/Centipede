#!/bin/bash

TOKEN=#PLACE TOKEN HERE
PAGE=100 # place number of returned results here

while read domain ; do
        curl -X 'GET' -s \
                'https://search.censys.io/api/v2/hosts/search?q=Relias&per_page=50&virtual_hosts=EXCLUDE' \
                -H 'accept: application/json' \
                -H "Authorization: Basic ${TOKEN}" | jq ."result"."hits"[]."ip" | sed 's/"//g'
done
