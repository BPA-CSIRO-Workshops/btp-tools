#!/bin/bash

# Git LFS
curl -sLo - https://github.com/github/git-lfs/releases/download/v0.6.0/git-lfs-linux-amd64-0.6.0.tar.gz | tar xvzf
cd git-lfs-*
./install.sh
