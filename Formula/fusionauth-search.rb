class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/1.4.0/fusionauth-search-1.4.0.zip"
  sha256 "385fbc5029bd7f61137c688a3965ce536b78d4b31653fbb7dc8fcad26870321c"

  depends_on :java => "1.8"

  bottle :unneeded

  keg_only "These libs are for internal commands, not for external linking."

  def install
    prefix.install "fusionauth-search"
    etc.install "config" => "fusionauth" unless File.exist? etc/"fusionauth"
    prefix.install_symlink etc/"fusionauth" => "config"
  end

  def post_install
    (var/"log/fusionauth").mkpath
  end

  plist_options :manual => "fusionauth start"

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
