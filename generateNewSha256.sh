
# To release (version 1.10.1 for example)
#
# - 1. ./generateNewSha256.sh 1.10.1
# - 2. Update the hash and version in each Formula
# - 3. Tag it
#       > git tag 1.10.1
#       > git push --tags

wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-app-${1}.zip"
wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-search-${1}.zip"

sha256sum ./fusionauth-app-${1}.zip
sha256sum ./fusionauth-search-${1}.zip
