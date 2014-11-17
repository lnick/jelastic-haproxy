#!/bin/bash

function _setPassword() {
  sed -i '/stats auth/d' /opt/repo/versions/1.5.3/conf/haproxy.conf;
  sed  '/stats enable/a stats auth ${J_OPENSHIFT_APP_ADM_USER}:${J_OPENSHIFT_APP_ADM_PASSWORD} ' /opt/repo/versions/1.5.3/conf/haproxy.conf;
}
