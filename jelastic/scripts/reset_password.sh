#!/bin/bash

function _setPassword() {
  sed -i '/stats auth/d' /opt/repo/versions/1.5.3/conf/haproxy.conf;
  sed -i "        /stats enable/a stats auth ${J_OPENSHIFT_APP_ADM_USER}:${J_OPENSHIFT_APP_ADM_PASSWORD}" /opt/repo/versions/1.5.3/conf/haproxy.conf;
  su - jelastic -c "${CARTRIDGE_HOME}/versions/1.5.3/bin/haproxy -D -f ${CARTRIDGE_HOME}/versions/1.5.3/conf/haproxy.conf -p ${CARTRIDGE_HOME}/run/haproxy.pid -sf $(cat ${CARTRIDGE_HOME}/run/haproxy.pid)"
}
