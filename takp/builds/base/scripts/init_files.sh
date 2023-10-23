#!/bin/bash

set -e

export serverroot=/build/out/Server
export serversource=/build/src/Server

cd /eqmacemu

echo Linking Files..
ln -sf $serverroot/utils/defaults/commands.pl .
ln -sf $serverroot/utils/defaults/plugin.pl .
ln -sf $serverroot/utils/defaults/worldui.pl .

echo Ensure logs directory present..
mkdir -p ./logs

echo Linking Opcodes..
mkdir -p ./assets/patches
ln -sf $serverroot/loginserver/login_util/login_opcodes.conf .
ln -sf $serverroot/loginserver/login_util/login_opcodes_oldver.conf .
ln -sf $serverroot/loginserver/login_util/login_opcodes_sod.conf .
ln -sf $serverroot/utils/patches/patch_Mac.conf ./assets/patches/patch_Mac.conf
ln -sf $serverroot/utils/patches/patch_Mac.conf .
ln -sf $serverroot/utils/patches/chat_opcodes.conf .
ln -sf $serverroot/utils/patches/opcodes.conf .

echo Copying Source..
rm -rf ./source && mkdir ./source
cp -r $serversource/. ./source

echo Linking Maps..
ln -sf /build/maps/Maps .

echo Linking Quests..
ln -sf /build/quests/quests .

echo Linking Server Binaries..
ln -sf $serverroot/bin/world .
ln -sf $serverroot/bin/zone .
ln -sf $serverroot/bin/ucs .
ln -sf $serverroot/bin/libcommon.a .
ln -sf $serverroot/bin/libluabind.a .
ln -sf $serverroot/bin/shared_memory .
ln -sf $serverroot/bin/queryserv .
ln -sf $serverroot/bin/loginserver .
ln -sf $serverroot/bin/eqlaunch .
ln -sf /build/zonelaunch.sh .

