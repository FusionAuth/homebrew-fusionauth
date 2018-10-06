class FusionAuthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/1.0.17/fusionauth-search-1.0.17.zip"
  sha256 "6ff66f7291c007095cffa09c087a9824d588107c60988d38dd95a529ca7aaac8"

  bottle :unneeded

  def install
    system "mkdir" "-p" "/usr/local/fusionauth/fusionauth-search"
    system "unzip" "-nq" "fusionauth-search-1.0.17.zip" "-d" "/usr/local/fusionauth"
  end

  test do
    system "ls" "/usr/local/inversoft/fusionauth-search"
  end
end
