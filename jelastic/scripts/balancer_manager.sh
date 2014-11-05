#!/bin/sh

function _setNeighbors(){
    return 0;
}

function _rebuildCommon(){
    sudo /etc/init.d/cartridge restart;
}

function _addCommonHost(){
    local last_node_id=$(cat ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    sed -i '/balance     roundrobin/a server webserver${$(( last_node_id + 1 ))} ${host}:80' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}

function _removeCommonHost(){
    sed -i '/${host}:80/d' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}


