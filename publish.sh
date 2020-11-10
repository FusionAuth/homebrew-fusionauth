
# To release (version 1.10.1 for example)
#
# >  ./release.sh 1.10.1

# Download files
if ! test -f "./fusionauth-app-${1}.zip"; then
  wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-app-${1}.zip"
fi

if ! test -f "./fusionauth-search-${1}.zip"; then
  wget "https://storage.googleapis.com/inversoft_products_j098230498/products/fusionauth/${1}/fusionauth-search-${1}.zip"
fi

# Update URL
sed -i -E "s/fusionauth\/(.*)\/fusionauth-app-(.*).zip\"$/fusionauth\/${1}\/fusionauth-app-${1}.zip\"/" ./Formula/fusionauth-app.rb
sed -i -E "s/fusionauth\/(.*)\/fusionauth-search-(.*).zip\"$/fusionauth\/${1}\/fusionauth-search-${1}.zip\"/" ./Formula/fusionauth-search.rb

# Update SHA 256 sum
sum=`sha256sum ./fusionauth-app-${1}.zip|awk -F" " '{print $1}'`
sed -i -E "s/sha256 \"(.*)\"$/sha256 \"${sum}\"/" ./Formula/fusionauth-app.rb

sum=`sha256sum ./fusionauth-search-${1}.zip|awk -F" " '{print $1}'`
sed -i -E "s/sha256 \"(.*)\"$/sha256 \"${sum}\"/" ./Formula/fusionauth-search.rb

git add .
git commit -m"release ${1}"
git push
git tag ${1}
git push --tags

rm fusionauth-app-${1}.zip
rm fusionauth-search-${1}.zip
