#!/bin/bash

# this script will take a domain/path or file with domains/paths and return login panels found

while read domain ; do
        
        # test initally
        login_panel=$(curl -sLk --connect-timeout 60 --max-time 300 ${domain} | grep 'type="password"')

        if [[ ${login_panel} ]] ; then
                
                # grab redirected endpoint and status code
                redirected=$(curl -skL -o /dev/null -w "%{url_effective} --> %{http_code}" ${domain})
                
                # print out results
                echo -e "${domain} --> ${redirected}"

        fi

done
