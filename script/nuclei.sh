#!/bin/bash

nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/cves/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-cves.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/exposures/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-exposures.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/misconfiguration/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-misconfiguration.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/vulnerabilities/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-vulnerabilities.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/takeovers/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-takeovers.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/default-logins/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-default-logins.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t ~/nuclei-templates/exposed-panels/ -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-exposed-panels.txt | sleep 5
