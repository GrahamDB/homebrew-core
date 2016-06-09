# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class MyproxyOauth < Formula
  desc "MyProxy OAuth Delegation Service"
  homepage "http://www.globus.org/"
  url "http://www.globus.org/ftppub/gt6/packages/myproxy_oauth-0.20.tar.gz"
  version "0.20"
  sha256 "0cf6735d1321c0dd77822bbed22ca3ce19a031b43c26efb3b4dada861e575859"


  depends_on :python if MacOS.version <= :snow_leopard

  resource "pycrypto" do
    url "https://pypi.python.org/packages/source/p/pycrypto/pycrypto-2.6.1.tar.gz"
    sha256 "f2ce1e989b272cfcb677616763e0a2e7ec659effa67a88aa92b3a65528f60a3c"
  end
  resource "M2Crypto" do
    url "https://pypi.python.org/packages/source/M/M2Crypto/M2Crypto-0.21.1.tar.gz"
    sha256 "25b94498505c2d800ee465db0cc1aff097b1615adc3ac042a1c85ceca264fc0a"
  end
  resource "cffi" do
    url "https://pypi.python.org/packages/source/c/cffi/cffi-1.5.2.tar.gz"
    sha256 "da9bde99872e46f7bb5cff40a9b1cc08406765efafb583c704de108b6cb821dd"
  end

  resource "cryptography" do
    url "https://pypi.python.org/packages/source/c/cryptography/cryptography-1.2.3.tar.gz"
    sha256 "8eb11c77dd8e73f48df6b2f7a7e16173fe0fe8fdfe266232832e88477e08454e"
  end

  resource "enum34" do
    url "https://pypi.python.org/packages/source/e/enum34/enum34-1.1.2.tar.gz"
    sha256 "2475d7fcddf5951e92ff546972758802de5260bf409319a9f1934e6bbc8b1dc7"
  end

  resource "idna" do
    url "https://pypi.python.org/packages/source/i/idna/idna-2.0.tar.gz"
    sha256 "16199aad938b290f5be1057c0e1efc6546229391c23cea61ca940c115f7d3d3b"
  end

  resource "ipaddress" do
    url "https://pypi.python.org/packages/source/i/ipaddress/ipaddress-1.0.16.tar.gz"
    sha256 "5a3182b322a706525c46282ca6f064d27a02cffbd449f9f47416f1dc96aa71b0"
  end

  resource "pyasn1" do
    url "https://pypi.python.org/packages/source/p/pyasn1/pyasn1-0.1.9.tar.gz"
    sha256 "853cacd96d1f701ddd67aa03ecc05f51890135b7262e922710112f12a2ed2a7f"
  end

  resource "pycparser" do
    url "https://pypi.python.org/packages/source/p/pycparser/pycparser-2.14.tar.gz"
    sha256 "7959b4a74abdc27b312fed1c21e6caf9309ce0b29ea86b591fd2e99ecdf27f73"
  end

  resource "pyOpenSSL" do
    url "https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.15.1.tar.gz"
    sha256 "f0a26070d6db0881de8bcc7846934b7c3c930d8f9c79d45883ee48984bc0d672"
  end

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
    # Remove unrecognized options if warned by configure
#    system "./configure", "--disable-debug",
#                          "--disable-dependency-tracking",
#                          "--disable-silent-rules",
#                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
#    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"
  end
end
