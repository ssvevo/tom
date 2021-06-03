#!/bin/bash

mkdir -p nuclei-output

nuclei -bs 40 -c 30  -l $1 -t ~/nuclei-templates/cves/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-cves.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/exposures/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-exposures.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/misconfiguration/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-misconfiguration.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/vulnerabilities/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-vulnerabilities.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/takeovers/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-takeovers.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/default-logins/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-default-logins.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/exposed-panels/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-exposed-panels.txt
nuclei -bs 40 -c 30 -l $1 -t ~/other-template/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-other-template.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/network/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-network.txt
nuclei -bs 40 -c 30 -l $1 -t ~/nuclei-templates/dns/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o ./nuclei-output/$1-dns.txt
