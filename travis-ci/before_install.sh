#!/usr/bin/env sh

set -ev

brew update

( brew ls -1 | grep -w ghostscript ) || brew install ghostscript
( brew ls -1 | grep -w md5sha1sum ) || brew install md5sha1sum
