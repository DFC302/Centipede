#!/bin/bash

# https://stackoverflow.com/questions/3252851/how-to-display-request-headers-with-command-line-curl

# This is better than -I option becaus it does not send a HEAD request, which could return different results.

# usage: echo <domain> | bash returnfullheader.sh
# usage: cat <file-with-domains> | bash returnfullheader.sh
while read domain ; do
	echo "${domain}"
	echo -e "------------------------------------------------------\n"
	curl -skLD - -o /dev/null ${domain}
	echo -e "------------------------------------------------------\n"
done
