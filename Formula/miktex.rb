class Miktex < Formula
  desc "TeX & Friends"
  homepage "https://miktex.org/"
  url "https://miktex.org/download/ctan/systems/win32/miktex/source/miktex-2.9.6341.tar.xz"
  sha256 "1e53d3dc69adb7645aeac3b341c5d80970ce15de3177e0d246d7057659f2d172"

  devel do
    url "https://github.com/MiKTeX/miktex.git", :branch => "next"
    version "2.9-next"
  end

#  bottle do
#    root_url "https://dl.bintray.com/miktex/bottles"
#    sha256 "d651052bc5bc81cbc1e51f87e2afeb4ddb292d04d4ba7e28bc6368f50a98aee7" => :sierra
#    sha256 "dc1a6ff2d897dfe89f561c0251b170615176d171b16d9363e683edd55eafdf1a" => :el_capitan
#    sha256 "3de88963cd3f110263faf32825ca473579724b4149364a9a6044f4c74b818a65" => :yosemite
#  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "icu4c"
  
  depends_on "cairo"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "fribidi"
  depends_on "gd"
  depends_on "gmp"
  depends_on "graphite2"
  depends_on "hunspell"
  depends_on "jpeg"
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
    mkdir "build" do
      system "cmake", "..",
             "-DMIKTEX_MPM_AUTO_ADMIN=t",
             "-DMIKTEX_MPM_AUTO_INSTALL=t",
             "-DMIKTEX_SYSTEM_ETC_FONTS_CONFD_DIR=#{etc}/fonts/conf.d",
             "-DMIKTEX_SYSTEM_VAR_CACHE_DIR=#{var}/cache",
             "-DMIKTEX_SYSTEM_VAR_LIB_DIR=#{var}/lib",
             *std_cmake_args
      system "make", "install"
    end
  end

  def caveats
    msg = <<-EOS.undent
      A bare MiKTeX installation has been set up in #{prefix}.
      Run 'initexmf --report' to view the installation details.

      MiKTeX is configured to install missing packages automatically for all users.
      Make sure that you have write privileges for #{prefix}.

      You can upgrade to a basic MiKTeX installation by running
        mpm --admin --package-level=basic --upgrade
    EOS
    msg
  end

  test do
    system "#{bin}/initexmf --report >> report.txt"
    assert_match /^MiKTeX: MiKTeX 2\.9/, File.read("report.txt")
  end
end
