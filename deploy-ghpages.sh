#!/bin/bash

# Configure git and clone the repo
git config --global user.email "travis@travis-ci.org"
git config --global user.name "travis-ci"
git clone --quiet --branch=gh-pages https://${GH_TOKEN}@${GH_REF} gh-pages > /dev/null

# Commit and Push the Changes
cd gh-pages
mkdir -p debs
cp -Rf ../pkg/*.deb ./debs
cd ./debs
git lfs track '*.deb'
git add -f '*.deb'
git commit -m "Latest DEB installers on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
git lfs ls-files
git push -fq origin gh-pages > /dev/null
