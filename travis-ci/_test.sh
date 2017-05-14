cd "${TRAVIS_BUILD_DIR}"

git clone https://github.com/MiKTeX/miktex-testing
cd miktex-testing
mkdir build
cd build

cmake ..

make test
