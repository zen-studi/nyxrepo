#!/bin/bash
echo "Adding NyxRepo..."
mkdir -p $PREFIX/etc/apt/sources.list.d
echo "deb https://raw.githubusercontent.com/zen-studi/nyxrepo/main stable main" > $PREFIX/etc/apt/sources.list.d/nyxrepo.list
pkg update
echo "Repo Added! Now run: pkg install nyxrecon"
