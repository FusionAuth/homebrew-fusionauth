class FusionauthApp < Formula
  desc "FusionAuth App"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.61.2/fusionauth-app-1.61.2.zip"
  sha256 "6b44f9550aed1096c508f093db9cc986c21e0ae788312bccab557a45124cf190"

  def install
    prefix.install "fusionauth-app"
    etc.install "config" => "fusionauth" unless File.exist? etc / "fusionauth"
    prefix.install_symlink etc / "fusionauth" => "config"
    (var / "fusionauth/java").mkpath unless File.exist? var / "fusionauth/java"
    prefix.install_symlink var / "fusionauth/java"
    (var / "log/fusionauth").mkpath unless File.exist? var / "log/fusionauth"
    prefix.install_symlink var / "log/fusionauth" => "logs"
  end

  def post_install
    #noop
  end

  def caveats
    <<~EOS
      Logs:   #{var}/log/fusionauth/fusionauth-app.log
      Config: #{etc}/fusionauth/fusionauth.properties
    EOS
  end

  service do
    run ["sh", "-x", "start.sh", "--debug"]
    keep_alive true
    working_dir opt_prefix/"fusionauth-app/bin"
    log_path var/"log/fusionauth/fusionauth-app.log"
    error_log_path var/"log/fusionauth/fusionauth-app.log"
  end
end
