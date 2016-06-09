# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Myproxy < Formula
  desc "Manage X.509 Public Key Infrastructure (PKI) security credentials"
  homepage "http://grid.ncsa.illinois.edu/myproxy/"
  url "http://toolkit.globus.org/ftppub/gt6/packages/myproxy-6.1.16.tar.gz"
  version "6.1.16"
  sha256 "299f6164942368cb25458964d7551cbb12aad33b488a98ce2b2ea360ef45a9bf"

#./configure --with-openldap=/usr --with-voms=/usr/local --with-kerberos5=/usr --with-sasl2=/usr --includedir="$globus_toolkit"/include/globus
  depends_on "voms-dev"
  depends_on "globus-toolkit"
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV.append_path "PKG_CONFIG_PATH", "#{Formula["globus-toolkit"].opt_libexec}/lib/pkgconfig"
    system "rm", "-f", "pkgdata/Makefile.am"
    system "rm", "-rf", "autom4te.cache"
    system "autoreconf", "-if"
    
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-openldap=/usr",
                          "--with-voms=/usr/local",
                          "--with-kerberos5=/usr",
                          "--with-sasl2=/usr", 
                          # "--includedir=/usr/local/opt/globus-toolkit/include/globus"
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"
  end
end
