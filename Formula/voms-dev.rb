# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class VomsDev < Formula
  desc "Virtual organization membership service Implementation"
  homepage "https://github.com/italiangrid/voms"
  url "https://github.com/italiangrid/voms/archive/v2.0.13.zip"
  version "2.0.13"
  sha256 "6f3e70547fdba66c7e0f2e53439b3e329509333ea1ac34d39652e5a2ffa9625a"

  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "gsoap" 
  depends_on "openssl"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "./autogen.sh"
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking", "--without-server",
                          "--disable-silent-rules", "--with-gsoap-wsdl2h=/usr/local/opt/gsoap/bin/wsdl2h",
                          "--prefix=#{prefix}", "SOAPCPP2=/usr/local/opt/gsoap/bin/soapcpp2",
                          "CXXFLAGS=-D_DARWIN_C_SOURCE"
    system "make", "SOAPCPP2=/usr/local/opt/gsoap/bin/soapcpp2", "install" # if this fails, try separate make/make install steps
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"
  end
end
