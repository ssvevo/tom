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

cd ~/Tools/

git clone https://github.com/Zarcolio/2cmd.git

cd 2cmd/

pip3 install termcolor
pip3 install colored
chmod +x install.sh

bash ./install.sh

cp ~/Tools/tom/script/2cmd/* ~/Tools/2cmd/2cmd.xmpls/

GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu

go get -u github.com/tomnomnom/httprobe
