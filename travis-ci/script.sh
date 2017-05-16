#!/usr/bin/env sh

set -ev

if [ "${MIKTEX_NEXT}" = "yes" ]; then
    installoptions=--devel
    versionname=devel
else
    versionname=stable
fi

brew tap miktex/miktex "${TRAVIS_BUILD_DIR}"
brew install jq
echo Installing MiKTeX version: `brew info --json=v1 miktex | jq ".[0].versions.${versionname}"`
brew install --verbose ${installoptions} miktex
initexmf --report

. "${TRAVIS_BUILD_DIR}/travis-ci/_install.sh"
. "${TRAVIS_BUILD_DIR}/travis-ci/_test.sh"
