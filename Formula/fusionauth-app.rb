class FusionauthApp < Formula
  desc "FusionAuth App"
  homepage "https://fusionauth.io"
  url "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/1.0.17/fusionauth-app-1.0.17.zip"
  sha256 "052c5acd5c75cc4d750fcaa940399fc2ec44c89d7c635973ded5f5897530ca03"

  bottle :unneeded

  def install
    mkdir_p "fusionauth"
    mv "fusionauth-app", "fusionauth/"
  end
end
