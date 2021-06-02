#! /bin/bash

echo -e "\e[1;32m

                                    .,  G:
  .    .                           ,Wt  E#,    :
  Di   Dt                 ..      i#D.  E#t  .GE
  E#i  E#i               ;W,     f#f    E#t j#K;  :KW,      L
  E#t  E#t              j##,   .D#i     E#GK#f     ,#W:   ,KG
  E#t  E#t             G###,  :KW,      E##D.       ;#W. jWi
  E########f.        :E####,  t#f       E##Wi        i#KED.
  E#j..K#j...       ;W#DG##,   ;#G      E#jL#D:       L#W.
  E#t  E#t         j###DW##,    :KE.    E#t ,K#j    .GKj#K.
  E#t  E#t        G##i,,G##,     .DW:   E#t   jD   iWf  i#K.
  f#t  f#t      :K#K:   L##,       L#,  j#t       LK:    t#E
   ii   ii     ;##D.    L##,        jt   ,;       i       tDj
               ,,,      .,,


 by: Hackx          \e[0m "


echo -e "\n\n"
echo -e "\e[1;34mCreating Directory for $1 *** \e[0m"
if [ ! -d "$1" ]; then
        mkdir -p Recon/$1
        mkdir -p Recon/$1/nuclei
		mkdir -p Recon/$1/naabu-nuclei
fi

echo -e "\e[1;34m\nRunning subfinder for $1 * \n \e[0m"
subfinder -t 100 -d $1 -silent -o Recon/$1/$1-subdomain.txt

echo -e "\e[1;34m\nRunning findomain for $1 * \n \e[0m"
findomain -t $1 -u Recon/$1/$1-subdomain.txt

echo -e "\e[1;34m\nRunning assetfinder for $1 * \n \e[0m"
assetfinder --subs-only $1 > Recon/$1/$1-assefinder.txt

echo -e "\e[1;34m\nRunning amass for $1 * \n \e[0m"
amass enum -timeout 10 -active -max-dns-queries 10000 -d $1 > Recon/$1/$1-amass.txt

echo -e "\e[1;34m\nRunning anew for $1 *** \n \e[0m"
cat Recon/$1/*.txt | anew >  Recon/$1/$1-allDomain.txt

rm -rf Recon/$1/$1-subdomain.txt Recon/$1/$1-subdomain.txt Recon/$1/$1-assefinder.txt Recon/$1/$1-amass.txt Recon/$1/$1-shuffledns.txt

echo -e "\e[1;34m\nRunning httprobe for $1 *** \n \e[0m"
cat Recon/$1/$1-allDomain.txt | httprobe -c 200 > Recon/$1/$1-httprobe.txt

echo -e "\e[1;34m\nRunning nuclei-templates updateing  for $1 *** \n \e[0m"
nuclei -update-templates

echo -e "\e[1;34m\nRunning nuclei-templates for $1 *** \n \e[0m"
nuclei -l Recon/$1/$1-httprobe.txt -t cves -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-cves.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t exposures -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-exposures .txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t misconfiguration -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-misconfiguration.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t miscellaneous -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-miscellaneous.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t vulnerabilities -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-vulnerabilities.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t default-logins -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-default-logins.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t exposed-panels -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-exposed-panels.txt | sleep 5
nuclei -l Recon/$1/$1-httprobe.txt -t takeovers -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/nuclei/$1-takeovers.txt | sleep 5

echo -e "\e[1;34m\nRunning gau for $1 *** \n \e[0m"
echo "$1" | gauplus -b ttf,woff,svg,png,jpg -o Recon/$1/$1-gau.txt

echo -e "\e[1;34m\nRunning grap JS.Json endpoint for $1 *** \n \e[0m"
cat Recon/$1/$1-gau.txt |  grep -P "\w+\.js(\?|$)" | tee Recon/$1/$1-js.txt && cat Recon/$1/$1-gau.txt | grep -P "\w+\.txt(\?|$)" | tee Recon/$1/$1-txt.txt && cat Recon/$1/$1-gau.txt |  grep -P "\w+\.json(\?|$)" | tee Recon/$1/$1-json.txt

rm -rf Recon/$1/$1-gau.txt

sleep 5

echo -e "\e[1;35m\nRunning naabu for $1 *** \n \e[0m"
naabu  -iL Recon/$1/$1-allDomain.txt -silent -warm-up-time 4 -top-ports 10000 -verify -o Recon/$1/$1-naabu.txt

echo -e "\e[1;35m\nRunning $1-naabulist httprobe for $1 *** \n \e[0m"
cat Recon/$1/$1-naabu.txt | httprobe -c 200 > Recon/$1/$1-naabu-httprobe.txt

echo -e "\e[1;35m\nRunning $1-naabulist nuclei for $1 *** \n \e[0m"
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t cves -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-cves.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t exposures -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-exposures .txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t misconfiguration -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-misconfiguration.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t miscellaneous -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-miscellaneous.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t vulnerabilities -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-vulnerabilities.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t default-logins -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-default-logins.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t exposed-panels -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-exposed-panels.txt | sleep 5
nuclei -l Recon/$1/$1-naabu-httprobe.txt -t takeovers -c 200 -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36' -o Recon/$1/naabu-nuclei/$1-takeovers.txt | sleep 5

echo -e "\e[1;35m\nRunning Subdoamin Takeover for $1 *** \n \e[0m"
python3 ~/Tools/subdover/subdover.py -t 200 -l Recon/$1/$1-allDomain.txt -o Recon/$1/$1-subdomain-takeover.txt
