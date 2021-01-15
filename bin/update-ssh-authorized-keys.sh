#!/bin/sh

cd ~/git/homedir-skel/
git pull >/dev/null 2>&1
chmod 600 .ssh/authorized_keys

