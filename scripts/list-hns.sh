#!/bin/bash

echo "Let's Go!"

subfinder -dL $1 -silent -o $1-sub-domains.txt
cat $1-sub-domains.txt | httpx -silent -o http-$1

bash ~/nuclei.sh http-$1 | notify

sleep 5

cat $1-sub-domains.txt |naabu -silent -o naabu-domains

cat naabu-domains | httprobe -c 200 > naabu-$1

bash ~/nuclei.sh naabu-$1 | notify

sleep 5

python3 ~/Tools/subdover/subdover.py -t 100 -l http-$1 -o $1-subdomain-takeover.txt

