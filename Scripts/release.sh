#!/bin/sh

new_version=$1

if [ -z "$new_version" ]; then
	echo "ERROR: version is empty"
	exit 1
fi

echo "Releasing version $new_version"

# Update project version

echo "Updating project verion"

/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $new_version" "Supporting Files/Info.plist"

# Update podspec version

echo "Updating podspec version"

podspec="Nuke-Alamofire-Plugin.podspec"
current_version_line=`grep -e "[a-zA-Z\s]*\.version\s*=\s*\"[0-9\.]*\"" "$podspec"`
current_version=$(echo $current_version_line | cut -f2 -d'"')
sed -i .backup "s/$current_version/$new_version/g" $podspec
rm "$podspec.backup"

# Create tag

echo "Creating tag"

git tag -a $new_version -m $new_version
git push
git push --tags
