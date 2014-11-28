#!/bin/bash

function _enableSSL(){
        doAction keystore DownloadKeys;
        cat /var/lib/jelastic/SSL/jelastic.crt /var/lib/jelastic/SSL/jelastic.key >> /var/lib/jelastic/SSL/jelastic.pem;
}

function _disableSSL(){
        doAction keystore remove;
        rm -f /var/lib/jelastic/SSL/jelastic.pem;
}
