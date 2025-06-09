#
# Copyright (c) 2019-2024, FusionAuth, All Rights Reserved
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
#

# To release (version 1.10.1 for example)
#
# >  ./release.sh 1.10.1

# Download sha256 sum files
rm -f fusionauth-app-${1}.zip.sha256
wget --no-verbose "https://files.fusionauth.io/products/fusionauth/${1}/fusionauth-app-${1}.zip.sha256"
rm -f fusionauth-search-${1}.zip.sha256
wget --no-verbose "https://files.fusionauth.io/products/fusionauth/${1}/fusionauth-search-${1}.zip.sha256"

# Handle platform differences in sed
function psed() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -E -i '' "${1}" "${2}"
  else
    sed -i -E "${1}" "${2}"
  fi
}

psed "s/fusionauth\/(.*)\/fusionauth-app-(.*).zip\"$/fusionauth\/${1}\/fusionauth-app-${1}.zip\"/" ./Formula/fusionauth-app.rb
psed "s/fusionauth\/(.*)\/fusionauth-search-(.*).zip\"$/fusionauth\/${1}\/fusionauth-search-${1}.zip\"/" ./Formula/fusionauth-search.rb

# Update SHA 256 sum
sum=`cat ./fusionauth-app-${1}.zip.sha256|awk -F" " '{print $1}'`
psed "s/sha256 \"(.*)\"$/sha256 \"${sum}\"/" ./Formula/fusionauth-app.rb

sum=`cat ./fusionauth-search-${1}.zip.sha256|awk -F" " '{print $1}'`
psed "s/sha256 \"(.*)\"$/sha256 \"${sum}\"/" ./Formula/fusionauth-search.rb

rm fusionauth-app-${1}.zip.sha256
rm fusionauth-search-${1}.zip.sha256

git add .
git commit -m"release ${1}"
git push
git tag ${1}
git push --tags
