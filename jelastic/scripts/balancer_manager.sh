#!/bin/sh

function _set_neighbors(){
    return 0;
}

function _rebuild_common(){
    /etc/init.d/cartridge restart;
}

function _add_common_host(){
    local last_node_id=$(cat ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    sed -i '/balance     roundrobin/a server webserver${$(( last_node_id + 1 ))} ${host}:80' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}

function _remove_common_host(){
    sed -i '/${host}:80/d' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
}

function _add_host_to_group(){
    return 0;
}

function _build_cluster(){
    return 0;
}

function _unbuild_cluster(){
    return 0;
}

function _clear_hosts(){
    return 0;
}

function _reload_configs(){
    return 0;
}

