class Miktex < Formula
  desc "TeX & Friends"
  homepage "https://miktex.org/"
#  url "https://miktex.org/download/ctan/systems/win32/miktex/source/miktex-2.9.6420.tar.xz"
  url "https://dl.bintray.com/miktex/source/miktex-2.9.6420.tar.xz"
  sha256 "5e683eb3d9780953b45b094d3fc7d4a01aa1f98d4ea827fce1c5b80a1f0662fa"

  devel do
    url "https://github.com/MiKTeX/miktex.git", :branch => "next"
    version "2.9-next"
  end

#  bottle do
#    #root_url "https://miktex.org/download/ctan/systems/win32/miktex/setup/mac"
#    root_url "https://dl.bintray.com/miktex/bottles"
#    sha256 "f49b7e8f1bec95e5914ea2d6e192cac623015a01d2a6b515607666f57ffb3aef" => :sierra
#    sha256 "b89618673b68a03ec52ee307a54c4b439ce26aff7fd480e9809914933a2eed06" => :el_capitan
#    sha256 "341da75bc0c7cc31aa29363fc527a80a3a7c0f0c61273274a8a59fd9c092912d" => :yosemite
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
