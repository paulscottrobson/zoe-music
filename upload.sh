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
mirror -R 
exit
EOF
echo
echo "Transfer finished"
date
