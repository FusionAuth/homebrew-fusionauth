# Copyright (c) 2024, FusionAuth, All Rights Reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

class FusionauthSearch < Formula
  desc "FusionAuth Search"
  homepage "https://fusionauth.io"
  url "https://files.fusionauth.io/products/fusionauth/1.53.1/fusionauth-search-1.53.1.zip"
  sha256 "976823fa042c35ce561863550c3300c0d19e8092b93befd12b2e2e498cd39f4c"

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
