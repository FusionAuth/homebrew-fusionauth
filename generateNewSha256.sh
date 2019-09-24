
wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-app-${1}.zip"
wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-search-${1}.zip"

sha256sum ./fusionauth-app-${1}.zip
sha256sum ./fusionauth-search-${1}.zip