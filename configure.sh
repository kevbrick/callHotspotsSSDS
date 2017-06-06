#!/bin/bash

INSTALLDIR=`pwd`

## Get packages
apt-get install -y r-base-core libxml2-dev libcurl4-openssl-dev python-setuptools python-pip
 
## Get R packages
echo 'install.packages(“RCurl”)' >Rconf.R
echo 'install.packages(“XML”)' >>Rconf.R
echo 'source("https://bioconductor.org/biocLite.R")' >>Rconf.R
echo 'biocLite("rtracklayer")' >>Rconf.R
echo 'biocLite("ShortRead")' >>Rconf.R

R --vanilla <Rconf.R 

## Get MACS
pip install --install-option="--prefix="$INSTALLDIR"/macs" -U MACS2==2.1.0.20150731 
MACSfolder=`which macs2`

## Get perl modules
cpan File::Temp
cpan Getopt::Long
cpan Math::Round
cpan Statistics::Descriptive
cpan List::Util

## Add environment vars to .bashrc
echo ' ' >>~/.bashrc
echo '## VARIABLES FOR callHotspots SSDS pipeline' >>~/.bashrc
echo 'export CHSPATH=$INSTALLDIR' >>~/.bashrc
echo 'export CHSNCISPATH=$CHSPATH/NCIS' >>~/.bashrc
echo 'export CHSBEDTOOLSPATH=$CHSPATH/bedtools' >>~/.bashrc
echo 'export CHSMACSPATH='$MACSfolder >>~/.bashrc
echo 'export CHSTMPPATH=/tmp' >>~/.bashrc
echo 'export PERL5LIB=$PERL5LIB:$CHSPATH' >>~/.bashrc
 
source ~/.bashrc