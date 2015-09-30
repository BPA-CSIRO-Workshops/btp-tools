[![Build Status](https://travis-ci.org/BPA-CSIRO-Workshops/btp-tools.svg?branch=master)](https://travis-ci.org/BPA-CSIRO-Workshops/btp-tools)

# Table of Contents

  - [Purpose](#purpose)
  - [Prerequisites](#prerequisites)
  - [Building the `deb` Packages](#building-the-deb-packages)
  - [License](#license)

# Purpose

This repository contains a set of [fpm-cookery](https://github.com/bernd/fpm-cookery) recipes for building `deb`
packages for a set of bioinformatics tools used in the Bioinformatics Training Platform (BTP). Each tool also contains
a standalone shell script tool installer.

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
fpm-cook package --target deb --platform ubuntu --pkg-dir ./pkg ./amos/recipe.rb
# You should now have a .deb file for AMOS
ls pkg/*.deb
```

A convienient way to build `deb` packages for all the tools:

```bash
find ./ -maxdepth 2 -type f -name recipe.rb -exec fpm-cook package --target deb --platform ubuntu --pkg-dir ./pkg {} \;
```
License
=======
The contents of this repository are released under the Creative Commons
Attribution 3.0 Unported License. For a summary of what this means,
please see:
http://creativecommons.org/licenses/by/3.0/deed.en_GB
