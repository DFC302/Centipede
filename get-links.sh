#!/bin/bash

while read url ; do
	echo -e "Domain: ${url}\n"
	curl -kLs ${url} --connect-timeout 60 --max-time 300 2>&1 | grep -oEe 'href="([^"#]+)"' -oEe "href='([^'#]+)'" -oEe 'src="([^"#]+)"' -oEe "src='([^'#]+)'" | cut -d'"' -f2 | cut -d"'" -f2 | sort -u
	echo -e "\n---------------------------------------------------------------\n"
done

# Telerik.Web.UI.WebResource.axd files grep -oP 'src=["\/a-zA-Z0-9.?=&;_\-\%+]+'