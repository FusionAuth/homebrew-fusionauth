class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.56.0/fusionauth-search-1.56.0.zip"
  sha256 "3bde2e91ac5e0ed429a0cf800f34b319c080aa7417bb183c0cb2d5d86dcd4ea7"

  def install
    prefix.install "fusionauth-search"
    etc.install "config" => "fusionauth" unless File.exist? etc/"fusionauth"
    prefix.install_symlink etc/"fusionauth" => "config"
    (var/"log/fusionauth").mkpath unless File.exist? var/"log/fusionauth"
    prefix.install_symlink var/"log/fusionauth" => "logs"
    (var/"fusionauth/java").mkpath unless File.exist? var/"fusionauth/java"
    prefix.install_symlink var/"fusionauth/java"
    (var/"fusionauth/data").mkpath unless File.exist? var/"fusionauth/data"
    prefix.install_symlink var/"fusionauth/data"

    # Hide all the dylibs from brew
    system("tar", "-cPf", prefix/"fusionauth-search/elasticsearch/modules.tar", prefix/"fusionauth-search/elasticsearch/modules", "-C", prefix/"fusionauth-search/elasticsearch")
    (prefix/"fusionauth-search/elasticsearch/modules").rmtree
  end

  def post_install
    # Fix all the dylibs now that brew will leave them alone
    system("tar", "-xPf", prefix/"fusionauth-search/elasticsearch/modules.tar", "-C", prefix/"fusionauth-search/elasticsearch")
    rm_f prefix/"fusionauth-search/elasticsearch/modules.tar"
  end

  def caveats; <<~EOS
      Logs:   #{var}/log/fusionauth/fusionauth-search.log
      Config: #{etc}/fusionauth/fusionauth.properties
    EOS
  end

  service do
    run ["sh", "./elasticsearch"]
    keep_alive true
    working_dir opt_prefix/"fusionauth-search/elasticsearch/bin"
    log_path var/"log/fusionauth/fusionauth-search.log"
    error_log_path var/"log/fusionauth/fusionauth-search.log"
  end
end
