#!/usr/bin/env sh

set -v

miktex_home="$HOME/.miktex"

if [ -f "${TRAVIS_BUILD_DIR}/miktex-testing/build/Testing/Temporary/LastTest.log" ]; then
   cat "${TRAVIS_BUILD_DIR}/miktex-testing/build/Testing/Temporary/LastTest.log"
fi

if [ -d "$miktex_home/texmfs/data/miktex/log" ]; then
    (cd "$miktex_home/texmfs/data/miktex/log"; cat *)
fi

if [ -d "/usr/local/var/log/miktex" ]; then
    (cd "/usr/local/var/log/miktex"; cat *)
fi
