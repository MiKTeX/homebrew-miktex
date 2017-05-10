#!/usr/bin/env sh

set -ev

brew install --verbose --build-bottle --devel "${TRAVIS_BUILD_DIR}/Formula/miktex-bare.rb"
brew bottle --verbose "${TRAVIS_BUILD_DIR}/Formula/miktex-bare.rb"
