#!/bin/bash

set -e

rm -rf /build/out/*
cp -R /build/src/Server /build/out/

cd /build/out/Server

cmake CMakeLists.txt
make -j$( nproc )

