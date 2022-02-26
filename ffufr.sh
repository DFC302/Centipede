#!/bin/bash

# parse multiple ffuf json results files for URL/URI and status codes

for file in "$@" ; do
	jq -r '.results[] | "\(.url) \(.status)"' $file 2> /dev/null | sort -u | sed 's/"//g'
done
