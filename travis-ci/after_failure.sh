#!/usr/bin/env sh

#set -ev

if [ -f "${TRAVIS_BUILD_DIR}/miktex-testing/build/Testing/Temporary/LastTest.log" ]; then
   curl -sT "${TRAVIS_BUILD_DIR}/miktex-testing/build/Testing/Temporary/LastTest.log" chunk.io
fi

if [ -d ~/.miktex/texmfs/data/miktex/log ]; then
    cd ~/.miktex/texmfs/data/miktex/log
    grep FATAL *.log
fi
