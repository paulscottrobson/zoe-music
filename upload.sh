#!/bin/sh
#  @author:       Alexandre Plennevaux
#  @description:  MIRROR DISTANT FOLDER TO LOCAL FOLDER VIA FTP
#
# FTP LOGIN
HOST='ftp.studio2.org.uk'
USER='zoe@studio2.org.uk'
PASSWORD='zoewadey000'

cd music
lftp -u "$USER","$PASSWORD" $HOST <<EOF
set ssl:verify-certificate no
set sftp:auto-confirm yes
set net:timeout 1000
set net:max-retries 0
mirror -R -n --parallel=10
exit
EOF
echo
echo "Transfer finished"
date
