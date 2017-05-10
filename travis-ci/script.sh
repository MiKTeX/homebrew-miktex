#!/usr/bin/env sh

set -ev

brew install "${TRAVIS_BUILD_DIR}/Formula/miktex-bare.rb" --verbose --devel
