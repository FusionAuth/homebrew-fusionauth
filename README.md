# homebrew-fusionauth
macOS [Homebrew](https://brew.sh/) tap for FusionAuth

Easy installation of FusionAuth via Homebrew.

Simply install and start the services. Then navigate to http://localhost:9011 and follow the setup.

## Install

```bash
brew tap fusionauth/homebrew-fusionauth
brew install fusionauth-app fusionauth-search
```

## Start

```bash
brew services start fusionauth-search
brew services start fusionauth-app
```

## Config

Logs: `/usr/local/var/log/fusionauth/`
Config file: `/usr/local/etc/fusionauth/fusionauth.properties`
