#!/bin/sh

function _set_neighbors(){
    return 0;
}

function _rebuild_common(){
    sed -i '/roundrobin$/,$d' ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf;
    cat ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts > ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf.tmp;
    cp ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf;
    sed '/backend app/a balance roundrobin' ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf;
    [ -f ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf.tmp;
    ${CARTRIDGE_HOME}/versions/1.5.3/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf;

}

function _add_common_host(){
    touch ${CARTRIDGE_HOME}/hosts;
    count=$(cat ${CARTRIDGE_HOME}/hosts | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    let "count+=1";
    grep -q "${host}:80" ${CARTRIDGE_HOME}/hosts  || echo "server webserver${count} ${host}:80" >> ${CARTRIDGE_HOME}/hosts;
    return 0;
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

