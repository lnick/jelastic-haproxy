#!/bin/bash

function setNeighbors(){
return 0;
}

function _rebuildCommon(){
sudo /etc/init.d/cartridge restart;
}

function _addCommonHost(){
sed '/balance     roundrobin/a server server1 ${host}:80' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}

function _removeCommonHost(){
sed '/${host}:80/d' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}


