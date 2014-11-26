#!/bin/bash

function _enableSSL(){
        local err;
        doAction keystore DownloadKeys;
        err=$?; [[ ${err} -gt 0 ]] && exit ${err};
}

function _disableSSL(){
        local err;
        doAction keystore remove;
        err=$?; [[ ${err} -gt 0 ]] && exit ${err};
}
