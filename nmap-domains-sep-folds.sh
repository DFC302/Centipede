#!/bin/bash

# This will take a list of domains, get the open ports, versions, all scripts, and output them in separate directories

while read url ; do
	# set filename like domain_com
    genericOut=$(echo ${url} | tr . _)

    # create a directory for each domain
    if [ ! -d ${genericOut} ] ; then
        mkdir ${genericOut}
    fi
    
    # nmap command
    nmap -sV -sC -p- ${url} -oA ${genericOut}/${genericOut}

done