#!/bin/sh

function _set_neighbors(){
    return 0;
}

function _rebuild_common(){
    sed -i '/###HTTP AND HTTPS SECTIONS ARE LISTED BELOW###$/,$d' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    echo $'backend bk_http\nmode http\nbalance roundrobin' >> ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts_http > ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    cp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    [ -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    echo $'backend bk_https\nmode tcp\nbalance roundrobin' >> ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts_https > ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    cp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    [ -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #cat ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf ${CARTRIDGE_HOME}/hosts > ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    #cp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    sed -i '/###BACKEND SECTIONS###/a ###HTTP AND HTTPS SECTIONS ARE LISTED BELOW###' ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf;
    #[ -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp ] && rm -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf.tmp;
    su - jelastic -c "${CARTRIDGE_HOME}/versions/1.5.8/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.8/conf/haproxy.conf -p ${CARTRIDGE_HOME}/run/haproxy.pid -sf $(cat ${CARTRIDGE_HOME}/run/haproxy.pid)"
}

function _add_common_host(){
    touch ${CARTRIDGE_HOME}/hosts_http;
    touch ${CARTRIDGE_HOME}/hosts_https;
    count=$(cat ${CARTRIDGE_HOME}/hosts_http | grep -o "webserver[0-9]" | sed 's/webserver//g' | sort | tail -n1);
    let "count+=1";
    grep -q "${host}:80" ${CARTRIDGE_HOME}/hosts_http  || echo "server webserver${count} ${host}:80" >> ${CARTRIDGE_HOME}/hosts;
    return 0;
    grep -q "${host}:443" ${CARTRIDGE_HOME}/hosts_https  || echo "server webserver${count} ${host}:80" >> ${CARTRIDGE_HOME}/hosts;
    return 0;
}



function _remove_common_host(){
    sed -i '/'${host}':80/d' ${CARTRIDGE_HOME}/hosts_http;
    sed -i '/'${host}':443/d' ${CARTRIDGE_HOME}/hosts_https;
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

