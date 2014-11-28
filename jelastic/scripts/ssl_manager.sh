#!/bin/bash

function _enableSSL(){
        doAction keystore DownloadKeys;
        cat /var/lib/jelastic/SSL/jelastic.crt /var/lib/jelastic/SSL/jelastic.key >> /var/lib/jelastic/SSL/jelastic.pem;
        sed -i '/bind :80/a bind :443 ssl crt /var/lib/jelastic/SSL/jelastic.pem' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
}

function _disableSSL(){
        doAction keystore remove;
        rm -f /var/lib/jelastic/SSL/jelastic.pem;
}
