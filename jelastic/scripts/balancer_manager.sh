#!/bin/bash

function setNeighbors(){
return 0;
}

function _rebuildCommon(){
rm -rf ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
cp ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf.tpl ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
sudo /etc/init.d/cartridge restart;
}

function _addCommonHost(){
sed '/#ip addresses of compute nodes are inserted after this string/a server webserver1 ${host}:80' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}

function _removeCommonHost(){
sed '/${host}:80/d' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}


