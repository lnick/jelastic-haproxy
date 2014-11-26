#!/bin/bash

function _enableSSL(){
        doAction keystore DownloadKeys;
}

function _disableSSL(){
        doAction keystore remove;
}
