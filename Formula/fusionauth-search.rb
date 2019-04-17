class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/1.5.0/fusionauth-search-1.5.0.zip"
  sha256 "fb455c27354a96cd31d67d6e7573e248109f8b6a707aeec7ca53e8b1cce6a875"

  depends_on :java => "1.8"

  bottle :unneeded

  def install
    prefix.install "fusionauth-search"
    etc.install "config" => "fusionauth" unless File.exist? etc/"fusionauth"
    prefix.install_symlink etc/"fusionauth" => "config"

    # Hide all the dylibs from brew
    system("tar", "-cf", prefix/"fusionauth-search/elasticsearch/modules.tar" , prefix/"fusionauth-search/elasticsearch/modules")
    (prefix/"fusionauth-search/elasticsearch/modules").rmtree
  end

  def post_install
    (var/"fusionauth/data").mkpath
    prefix.install_symlink var/"fusionauth/data"
    (var/"log/fusionauth").mkpath

    # Fix all the dylibs now that brew will leave them alone
    system("tar", "-xf", prefix/"fusionauth-search/elasticsearch/modules.tar", "-C", "/")
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
