#!/bin/bash

while read url ; do
	# set filename like domain_com
    filename=$(echo ${url} | tr . _)
    
    # create a directory for each domain
    if [ ! -d ${filename} ] ; then
        mkdir ${filename}
    fi

    # grab all urls with gau
    gau ${url} | sort -u | tee -a ${filename}/"${filename}.txt"

    # check with httpx to verify alive
    cd ${filename}/ && cat "${filename}.txt" | ~/go/bin/httpx -t 70 -silent -mc 200,404,401,403,503,500,302,301 | ~/go/bin/aquatone -ports 80,443 -threads 70 -no-redirect
    
    # cd back out of directory to make sure next domain is not saved in wrong folder
    cd ../
done