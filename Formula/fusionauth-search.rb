class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/1.0.17/fusionauth-search-1.0.17.zip"
  sha256 "6ff66f7291c007095cffa09c087a9824d588107c60988d38dd95a529ca7aaac8"

  bottle :unneeded

  def install
    system "mkdir", "-p", "fusionauth/fusionauth-search"
    system "unzip", "-nq", "fusionauth-search-1.0.17.zip", "-d", "fusionauth"
  end

  test do
    system "ls", "fusionauth/fusionauth-search"
  end
end
