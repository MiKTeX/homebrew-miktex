# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Miktex < Formula
  desc "An implementation of TeX & Friends"
  homepage "https://miktex.org"
  url "https://miktex.org/download/ctan/systems/win32/miktex/source/miktex-2.9.6300.tar.xz"
  sha256 "5ad6bc697ef2c33a4e87937d01e216f13fa5ed0ee4c6845e8c5da312b8c96ec3"

  devel do
    url "https://github.com/MiKTeX/miktex.git", :branch => "next"
    version "2.9-next"
  end

  depends_on "cmake" => :build
  depends_on "dos2unix" => :build
  depends_on "fop" => :build
  depends_on "pkg-config" => :build
  depends_on "pandoc" => :build

  depends_on "apr"
  depends_on "apr-util"
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "fribidi"
  depends_on "gd"
  depends_on "glib"
  depends_on "gmp"
  depends_on "graphite2"
  depends_on "harfbuzz"
  depends_on "hunspell"
  depends_on "icu4c"
  depends_on "jpeg"
  depends_on "libffi"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libzzip"
  depends_on "log4cxx"
  depends_on "mpfr"
  depends_on "openssl"
  depends_on "pixman"
  depends_on "poppler"
  depends_on "popt"
  depends_on "potrace"
  depends_on "uriparser"
  depends_on "xz"

  needs :cxx14
  
  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV.deparallelize

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test miktex`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "#{bin}/initexmf", "--report"
  end
end
