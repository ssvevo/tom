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
subfinder -t 100 -d $1 -silent -o Recon/$1/$1-subdomains.txt

echo -e "\e[1;34m\nRunning findomain for $1 * \n \e[0m"
findomain -t $1 -u Recon/$1/$1-subdomain.txt

echo -e "\e[1;34m\nRunning assetfinder for $1 * \n \e[0m"
assetfinder --subs-only $1 > Recon/$1/$1-assefinder.txt

echo -e "\e[1;34m\nRunning anew for $1 *** \n \e[0m"
cat Recon/$1/*.txt | anew >  Recon/$1/$1-allDomain.txt

rm -rf Recon/$1/$1-subdomains.txt Recon/$1/$1-subdomain.txt Recon/$1/$1-assefinder.txt 

echo -e "\e[1;34m\nRunning httprobe for $1 *** \n \e[0m"
cat Recon/$1/$1-allDomain.txt | httprobe -c 200 > Recon/$1/$1-httprobe.txt

echo -e "\e[1;34m\nRunning nuclei-templates updateing  for $1 *** \n \e[0m"
nuclei -update-templates

echo -e "\e[1;34m\nRunning nuclei-templates for $1 *** \n \e[0m"
bash ~/script/nuclei.sh $1 | bash ~/tools/tom/script/notify.sh

echo -e "\e[1;34m\nRunning gau for $1 *** \n \e[0m"
cat Recon/$1/$1-httprobe.txt | gau -o Recon/$1/$1-gau.txt

echo -e "\e[1;34m\nRunning grap JS.Json endpoint for $1 *** \n \e[0m"
cat Recon/$1/$1-gau.txt |  grep -P "\w+\.js(\?|$)" | tee Recon/$1/$1-js.txt && cat Recon/$1/$1-gau.txt | grep -P "\w+\.txt(\?|$)" | tee Recon/$1/$1-txt.txt && cat Recon/$1/$1-gau.txt |  grep -P "\w+\.json(\?|$)" | tee Recon/$1/$1-json.txt

rm -rf Recon/$1/$1-gau.txt

echo -e "\e[1;35m\nRunning naabu for $1 *** \n \e[0m"
cat  Recon/$1/$1-allDomain.txt |naabu -silent -o Recon/$1/$1-naabu.txt

echo -r "\e[1;35m\nRunning $1-naabulist httprobe for $1 *** \n \e[0m"
cat Recon/$1/$1-naabu.txt | httprobe -c 200 > Recon/$1/$1-naabu-httprobe.txt

echo -r "\e[1;35m\nRunning $1-naabulist nuclei for $1 *** \n \e[0m"
bash ~/script/naabu-nuclei.sh $1 | bash ~/tools/tom/script/naabu-notify.sh

echo -r "\e[1;35m\nRunning Subdoamin Takeover for $1 *** \n \e[0m"
python3 ~/tools/subdover/subdover.py -t 200 -l Recon/$1/$1-httprobe.txt -o Recon/$1/$1-subdomain-takeover.txt
