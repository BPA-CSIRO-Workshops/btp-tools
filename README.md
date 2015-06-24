[![Build Status](https://travis-ci.org/BPA-CSIRO-Workshops/btp-tools.svg?branch=master)](https://travis-ci.org/BPA-CSIRO-Workshops/btp-tools)

This repository contains a set of [fpm-cookery](https://github.com/bernd/fpm-cookery) recipes for building `deb`
packages for a set of bioinformatics tools used in the Bioinformatics Training Platform (BTP).

# Table of Contents

  - [Prerequisites](#prerequisites)
  - [Building the `deb` Packages](#building-the-deb-packages)

# Prerequisites
The things you need to have installed in order to use the recipes and build `deb` packages yourself are:

  * Ruby environment
  * RubyGems package managment tool
  * fpm-cookery Gem

On an Ubuntu system, this can be achieved with the following few commands:

```bash
apt-get install -y rubygems
gem install fpm-cookery
```

# Building the `deb` Packages
Once you have cloned this repository, you can start building the `deb` packages using the recipes:

```bash
# Build the AMOS .deb
cd amos
fpm-cook
# You should now have a .deb file for AMOS
ls pkg/*.deb
```

A convienient way to build `deb` packages for all the tools:

```bash
find ./ -maxdepth 1 -type d -exec sh -c 'cd "$0" && fpm-cook' {} \;
```

