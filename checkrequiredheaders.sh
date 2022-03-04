#!/bin/bash

# Good for pentesters who need to check multiple targets for missing headers. Feel free to add your own

# usage: echo <domain> | bash checkrequiredheaders.sh
# usage: cat <file-with-domains> | bash checkrequiredheaders.sh

while read domain ; do
        curl -skLI ${domain} -o /tmp/curl-response.txt

        XFrameOptions=$(cat /tmp/"curl-response.txt" | grep -E "[xX]-[fF]rame-[oO]ptions")
        HSTS=$(cat /tmp/"curl-response.txt" | grep -E "[sS]trict-[tT]ransport-[sS]ecurity")
        XSSProtection=$(cat /tmp/"curl-response.txt" | grep -E "[xX]-[xssXSS]+-[pP]rotection")
        CacheControl=$(cat /tmp/"curl-response.txt" | grep -E "[cC]ache-[cC]ontrol")
        ContentSecurityPolicy=$(cat /tmp/"curl-response.txt" | grep -E "[cC]ontent-[sS]ecurity-[pP]olicy")

        if ! ([[ ${XFrameOptions} == 0 ]] || [[ ${HSTS} == 0 ]] || [[ ${XSSProtection} == 0 ]] || [[ ${CacheControl} == 0 ]] || [[ ${ContentSecurityPolicy} == 0 ]])  ; then
                echo ${domain}:

                if ! [[ ${XFrameOptions} ]] ; then
                        echo -e "\t-missing X-Frame-Options header!"
                fi

                if ! [[ ${HSTS} ]] ; then
                        echo -e  "\t-missing Strict-Transport-Security header!"
                fi

                if ! [[ ${XSSProtection} ]] ; then
                        echo -e  "\t-missing X-XSS-Protection header!"
                fi

                if ! [[ ${CacheControl} ]] ; then
                        echo -e "\t-missing Cache-Control header!"
                fi

                if ! [[ ${ContentSecurityPolicy} ]] ; then
                        echo -e "\t-missing Content-Security-Policy header!"
                fi

                echo ""
            fi

        rm /tmp/curl-response.txt
done
