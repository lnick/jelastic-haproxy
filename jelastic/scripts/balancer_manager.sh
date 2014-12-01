#!/bin/sh

function _set_neighbors(){
    return 0;
}

function _rebuild_common(){
    #sed -i '/balance$/,$d' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #echo $'\nbackend bk_http\nmode http\nbalance roundrobin' >> ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts > ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #cp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #[ -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #echo $'\nbackend bk_https\nmode tcp\nbalance roundrobin' >> ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts_https > ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #cp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #[ -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #sed -i '/###BACKEND SECTIONS###/a ###HTTP AND HTTPS SECTIONS ARE LISTED BELOW###' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    su - jelastic -c "${CARTRIDGE_HOME}/versions/1.5.8/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf -p ${CARTRIDGE_HOME}/run/haproxy.pid -sf $(cat ${CARTRIDGE_HOME}/run/haproxy.pid)"
}

function _add_common_host(){
    grep -q "${host}" ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf && return 0;
    count=$(cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    let "count+=1";
    echo "server webserver${count} ${host}:80 check" >> ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
}



function _remove_common_host(){
    sed -i '/'${host}'/d' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
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
