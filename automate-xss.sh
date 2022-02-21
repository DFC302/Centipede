#!/bin/bash

while read url ; do
    # set filename like domain_com
    filename=$(echo ${url} | tr . _)

    # make sure blind payload is set for xss hunter -- otherwise it will just skip this step
    python3 ~/XSStrike/xsstrike.py -u ${url} --fuzz --blind 2>/dev/null | tee -a results.txt

done