#!/bin/bash
echo "Adding NyxRepo..."
echo "deb [trusted=yes] https://raw.githubusercontent.com/zen-studi/nyxrepo/main ./" > $PREFIX/etc/apt/sources.list.d/nyxrepo.list
pkg update
echo "Repo ready! Run: pkg install nyxrecon"
