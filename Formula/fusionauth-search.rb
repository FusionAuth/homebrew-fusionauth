class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.53.3/fusionauth-search-1.53.3.zip"
  sha256 "79a6bad27947185e41664a7b698bbed450fcb35d6a5e69b3f00c9491dcb084e1"

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

  # http://www.manpagez.com/man/5/launchd.plist/
  def plist; <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>sh</string>
          <string>./elasticsearch</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{prefix}/fusionauth-search/elasticsearch/bin</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/fusionauth/fusionauth-search.log</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/fusionauth/fusionauth-search.log</string>
      </dict>
      </plist>
    EOS
  end
end
