#!/bin/bash

function _enableSSL(){
        doAction keystore DownloadKeys;
        cat /var/lib/jelastic/SSL/jelastic.crt /var/lib/jelastic/SSL/jelastic.key >> /var/lib/jelastic/SSL/jelastic.pem;
        sed -i '/bind :80/a bind :443 ssl crt /var/lib/jelastic/SSL/jelastic.pem' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
        su - jelastic -c "${CARTRIDGE_HOME}/versions/1.5.8/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf -p ${CARTRIDGE_HOME}/run/haproxy.pid -sf $(cat ${CARTRIDGE_HOME}/run/haproxy.pid)"
}

function _disableSSL(){
        doAction keystore remove;
        sed -i '/ssl crt/d' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
        rm -f /var/lib/jelastic/SSL/jelastic.pem;
        su - jelastic -c "${CARTRIDGE_HOME}/versions/1.5.8/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf -p ${CARTRIDGE_HOME}/run/haproxy.pid -sf $(cat ${CARTRIDGE_HOME}/run/haproxy.pid)"
}
