#!/bin/bash
VERSION=1.0.0
rm -rf distributable
mkdir -p distributable/{linux32,linux64,windows,macosx,linuxarm,linuxarm64}
export GOPATH=$PWD
GOOS=linux GOARCH=amd64 go build -o distributable/linux64/expand-property-map main.go
GOOS=linux GOARCH=386 go build -o distributable/linux32/expand-property-map main.go
GOOS=linux GOARCH=arm go build -o distributable/linuxarm/expand-property-map main.go
GOOS=linux GOARCH=arm64 go build -o distributable/linuxarm64/expand-property-map main.go
GOOS=darwin GOARCH=amd64 go build -o distributable/macosx/expand-property-map main.go
GOOS=windows GOARCH=386 go build -o distributable/windows/expand-property-map.exe main.go
cd distributable
ls | xargs -I {} tar cjvf expand-property-map-$VERSION-{}.tar.bz2 {}
ls -la *.tar.bz2
sha256sum *.tar.bz2
