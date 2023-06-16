#!/bin/bash

## from https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_R_source.sh
##
## Install R from source.
##
## In order of preference, first argument of the script, the R_VERSION variable.
## ex. latest, devel, patched, 4.0.0
##
## 'devel' means the prerelease development version (Latest daily snapshot of development version).
## 'patched' means the prerelease patched version (Latest daily snapshot of patched version).

set -e

R_VERSION=3.5.0


# shellcheck source=/dev/null
source /etc/os-release

apt-get update
apt-get -y install locales

## Configure default locale
LANG=${LANG:-"en_US.UTF-8"}
/usr/sbin/locale-gen --lang "${LANG}"
/usr/sbin/update-locale --reset LANG="${LANG}"

export DEBIAN_FRONTEND=noninteractive

##R_HOME=${R_HOME:-"/usr/local/lib/R"}

R_HOME=${R_HOME:-"/usr/local/lib/R"}

READLINE_VERSION=7
if [ "${UBUNTU_CODENAME}" == "bionic" ]; then
    READLINE_VERSION=7
fi

apt-cache search libreadline7

apt-get -y install \
        wget \
        build-essential \
        software-properties-common \
        apt-transport-https \
        locales \
        libxml2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
	freeglut3-dev \
        libtinfo5


wget "http://de.archive.ubuntu.com/ubuntu/pool/main/r/readline/libreadline7_7.0-3_amd64.deb"

dpkg -i libreadline7_7.0-3_amd64.deb

wget "http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3.2_amd64.deb"
dpkg -i libicu60_60.2-3ubuntu3.2_amd64.deb

# Install R from CRAN repository

rm -f /usr/local/bin/R
rm -f /usr/local/bin/Rscript
rm -rf /usr/local/lib/R/site-library


apt purge r-base* r-recommended r-cran-*
apt autoremove

echo 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
apt-get update

# sudo apt install r-base-dev


cat /etc/apt/sources.list


apt-get update

# apt install -y -t  bionic-cran35 --no-install-recommends r-cran-cluster/bionic-cran35

apt-get -y install -t  bionic-cran35 --no-install-recommends  \
        r-base=${R_VERSION}* \
        r-base-core=${R_VERSION}* \
        r-base-dev=${R_VERSION}* \
        r-recommended=${R_VERSION}* \
        r-base-html=${R_VERSION}* \
        r-doc-html=${R_VERSION}* \
        r-cran-cluster=2.0.8-1bionic0 \
        r-cran-lattice=0.20-35-1cranBionic0 \
        r-cran-mgcv=1.8-23-1cranBionic0 \
        r-cran-nlme=3.1.139-1bionic0 \
        r-cran-rpart=4.1-15-1cran1bionic0 \
        r-cran-survival=2.42-6-1cran1bionic0 \
        r-cran-mass=7.3-50-1bionic0 \
        r-cran-class=7.3-15-1 \
        r-cran-nnet=7.3-12-2cranArtful0~ubuntu18.04.1~ppa1 \
        r-cran-matrix=1.2-14-1cranBionic0 \
        r-cran-foreign=0.8.70-1cranArtful0~ubuntu18.04.1~ppa1

 # r-cran-foreign : Depends: r-base-core (>= 3.6.1-3bionic) but 3.5.0-1bionic is to be installed
 # r-cran-nnet : Depends: r-base-core (>= 3.6.2.20200221-1) but 3.5.0-1bionic is to be installed
 


# cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*

    
## Clean up from R source install
cd ..
rm -rf /tmp/*
rm -rf R-*/
rm -rf "R.tar.gz"


# shellcheck disable=SC2086
apt-get remove --purge -y ${BUILDDEPS}
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*

## Fix library path
echo "R_LIBS=\${R_LIBS-'${R_HOME}/site-library:${R_HOME}/library'}" >>"${R_HOME}/etc/Renviron.site"


# Check the R info
echo -e "Check the R info...\n"

R -q -e "sessionInfo()"

which R

ln -s /usr/bin/R /usr/local/bin/R
ln -s /usr/bin/Rscript /usr/local/bin/Rscript
