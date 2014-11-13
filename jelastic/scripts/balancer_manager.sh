#!/bin/sh

function _set_neighbors(){
    return 0;
}

function _rebuild_common(){
    sed -i '/balance roundrobin/,$d' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
    cat ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf ${OPENSHIFT_HAPROXY_DIR}/hosts > ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf.tmp;
    cp ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf.tmp ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
    sed '/backend app/a balance roundrobin' ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;
    rm -rf ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf.tmp;
    rm -rf ${OPENSHIFT_HAPROXY_DIR}/hosts;
    ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/bin/haproxy -D -f ${OPENSHIFT_HAPROXY_DIR}/versions/1.5.3/conf/haproxy.conf;

}

function _add_common_host(){    
    touch ${OPENSHIFT_HAPROXY_DIR}/hosts;
    count=$(cat /opt/repo/hosts | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    let "count+=1";
    echo "server webserver${count} ${host}:80" >> ${OPENSHIFT_HAPROXY_DIR}/hosts;
}


function _remove_common_host(){
    sed -i '/'${host}':80/d' ${OPENSHIFT_HAPROXY_DIR}/hosts;
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

