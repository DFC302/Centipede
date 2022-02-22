#!/bin/bash

while read domain ; do
	amass enum -d ${domain} -brute -w <path to wordlists> -ip -o amass.txt -silent
  
	subfinder -d ${domain} -silent -o subfinder.txt

	assetfinder ${domain} | tee -a assetfinder.txt

	python3 /root/Sublist3r/sublist3r.py -d ${domain} -n -o sublister.txt

	cat amass.txt | cut -d' ' -f1 | sort -u | tee -a all.txt
	cat subfinder.txt assetfinder.txt sublister.txt | sort -u | tee -a all.txt && rm subfinder.txt assetfinder.txt sublister.txt # keep amass.txt -- has IP information

	cat all.txt | dnsgen - | sort -u | tee -a alterations.txt

done
