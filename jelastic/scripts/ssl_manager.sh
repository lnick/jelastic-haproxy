#!/bin/bash

function _enableSSL(){
doAction keystore DownloadKeys;
return 0;
}

function _disableSSL(){
doAction keystore remove;
return 0;
}
