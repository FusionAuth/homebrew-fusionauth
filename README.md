# homebrew-fusionauth
macOS [Homebrew](https://brew.sh/) tap for FusionAuth

Easy installation of FusionAuth via Homebrew.

Simply install and start the services. Then navigate to http://localhost:9011 and follow the setup prompts.

The following examples assume you will be installing both `fusionauth-app` and `fusionauth-search`.
If you have access to another instance of Elasticsearch that meets the minimum requirement, you may omit the `fusionauth-search` service.


## Install

```bash
brew tap fusionauth/fusionauth
brew install fusionauth-app fusionauth-search
```

## Start

```bash
brew services start fusionauth-search
brew services start fusionauth-app
```

## Upgrade

```bash
brew upgrade fusionauth-app
brew upgrade fusionauth-search
```

## Config

Logs: `/usr/local/var/log/fusionauth/`
Config file: `/usr/local/etc/fusionauth/fusionauth.properties`

## Test
If fusionauth is already installed via homebrew, you need to uninstall it.
    
```bash
brew uninstall fusionauth-app fusionauth-search
```

Then to test that this works, run the following command from this diretory:

```bash
brew install ./Formula/fusionauth-app.rb
brew install ./Formula/fusionauth-search.rb
```

## Release

Using Savant
```bash
sb publish
```

Without using Savant
```bash
./publish.sh <version>
```
