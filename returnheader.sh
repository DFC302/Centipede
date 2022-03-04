#!/bin/bash

# usage: echo <domain> | bash returnheader.sh
# usage: cat <file-with-domains> | bash returnheader.sh

while read domain ; do
    header=$(curl -ILks ${domain} --max-time 15 --connect-timeout 60 | grep "server:\|Server:" | sort -u)

    echo -e "${domain}\t${header}"

done
