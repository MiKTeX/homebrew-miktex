class Miktex < Formula
  desc "TeX & Friends"
  homepage "https://miktex.org/"
  #url "https://miktex.org/download/ctan/systems/win32/miktex/source/miktex-2.9.6470.tar.xz"
  url "https://dl.bintray.com/miktex/source/miktex-2.9.6470.tar.xz"
  sha256 "e6b21af4dd577fd4d613dc1793339c368da86df92004a05dc63686c76eaab364"

  devel do
    url "https://github.com/MiKTeX/miktex.git", :branch => "next"
    version "2.9-next"
  end

#  bottle do
#    root_url "https://miktex.org/download/ctan/systems/win32/miktex/setup/mac"
#    #root_url "https://dl.bintray.com/miktex/bottles"
#    sha256 "" => :high_sierra
#    sha256 "bda2c25f40bea07abbcda12a81558dbab74c6cc52f4384c15ecc9ba5ae08525d" => :sierra
#    sha256 "410eb5a64ef3490d0e114c5cd332e9cec9126b8695675df2e5b2a5d947f68370" => :el_capitan
#    sha256 "66621ff2fc8b3a7b0320fd68cd068e2a461a7922fd9216e01a2f97bae1867639" => :yosemite
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
             "-DMIKTEX_SYSTEM_VAR_LOG_DIR=#{var}/log",
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
