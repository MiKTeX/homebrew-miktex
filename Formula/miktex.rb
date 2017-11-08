class Miktex < Formula
  desc "TeX & Friends"
  homepage "https://miktex.org/"
  url "https://miktex.org/download/ctan/systems/win32/miktex/source/miktex-2.9.6500.tar.xz"
  #url "https://dl.bintray.com/miktex/source/miktex-2.9.6481.tar.xz"
  sha256 "cf9ebc03bafa8bf63f20b84579e1bdf86d95d4a32b881e012efc574069b4c5cb"

  devel do
    url "https://github.com/MiKTeX/miktex.git", :branch => "next"
    version "2.9-next"
  end

#  bottle do
#    #root_url "https://miktex.org/download/ctan/systems/win32/miktex/setup/mac"
#    root_url "https://dl.bintray.com/miktex/bottles"
#    #sha256 "" => :high_sierra
#    sha256 "560bbc5d7a62445ed5938c9f7691058ded39ffbad679d8948cd4afdb1dff7333" => :sierra
#    #sha256 "" => :el_capitan
#    #sha256 "" => :yosemite
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
             "-DUSE_SYSTEM_POPPLER=FALSE",
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
