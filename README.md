# homebrew-fusionauth
macOS [Homebrew](https://brew.sh/) tap for FusionAuth

Easy installation of FusionAuth via Homebrew.

Simply install and start the services. Then navigate to http://localhost:9011 and follow the setup prompts.

# Installation

The following examples assume you will be installing `fusionauth-app`. And `postgresql` as well as `opensearch` as prerequisites.

## Prerequisites

FusionAuth requires a database and a search engine. The recommended database is PostgreSQL, and the recommended search engine is OpenSearch.

### Postgres

If you don't have PostgreSQL installed, you can install it using Homebrew:

```bash
# Install PostgreSQL 16
brew install postgresql@16
# Check the service status
brew services info postgresql@16
# Start PostgreSQL 16 service
brew services start postgresql@16
```

To run the FusionAuth installation in silent mode, you need to create a PostgreSQL user and database for FusionAuth. You can do this with the following commands:

```bash
# Ensure the PostgreSQL binaries are in your PATH
export PATH="$PATH:$(brew --prefix postgresql@16)/bin"
# Create the fusionauth user fusionauth with password fusionauth
psql --command="CREATE USER fusionauth PASSWORD 'fusionauth'" --command="\du" postgres
# Create the fusionauth database owned by the fusionauth user
createdb --owner=fusionauth fusionauth
```

### OpenSearch

If you don't have OpenSearch installed, you can install it using Homebrew:

```bash
brew install opensearch
brew services info opensearch
brew services start opensearch
```

## FusionAuth

To install FusionAuth using Homebrew, you can use the following commands:

```bash
brew tap fusionauth/fusionauth
brew install fusionauth-app
```

### Configure

After installing FusionAuth, you can configure it before starting the service to run a silent configuration. . The configuration file is located at `$(brew --prefix)/etc/fusionauth/fusionauth.properties`.

```bash
# Add linebreak to the end of the fusionauth.properties file
echo "" >> $(brew --prefix)/etc/fusionauth/fusionauth.properties
# Add your kickstart file path
echo "fusionauth-app.kickstart.file=/path/to/your/kickstart/kickstart.json" >> $(brew --prefix)/etc/fusionauth/fusionauth.properties
# Add the silent mode property
echo "fusionauth-app.silent-mode=true" >> $(brew --prefix)/etc/fusionauth/fusionauth.properties
# Check the full configuration
cat $(brew --prefix)/etc/fusionauth/fusionauth.properties
```

### Start

After configuring FusionAuth, you can start the service using Homebrew:

```bash
brew services start fusionauth-app
```

### Status

You can check the status of the FusionAuth service using:

```bash
brew services info fusionauth-app
```

And check the logs using:

```bash
cat $(brew --prefix)/var/log/fusionauth/fusionauth-app.log
```

### Upgrade

To upgrade FusionAuth, you can use the following command:

```bash
brew upgrade fusionauth-app
```

### Stop

To stop the FusionAuth service, you can use:

```bash
brew services stop fusionauth-app
```
