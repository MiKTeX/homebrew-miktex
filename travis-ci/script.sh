#!/usr/bin/env sh

set -ev

brew tap miktex/miktex "${TRAVIS_BUILD_DIR}"
brew install jq
brew info --json=v1 miktex-bare | jq .
brew install --verbose --build-bottle --devel miktex-bare
brew bottle --verbose miktex-bare
