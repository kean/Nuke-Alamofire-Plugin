#!/bin/sh

new_version=$1
plist="Supporting Files/Info.plist"
podspec="Nuke-Alamofire-Plugin.podspec"

if [ -z "$new_version" ]; then
	echo "ERROR: version is empty"
	exit 1
fi

if [ ! -d "$plist" ]; then
    echo "ERROR: $plist not found"
	exit  1
fi

if [ ! -d "$podspec" ]; then
    echo "ERROR: $podspec not found"
	exit  1
fi

echo "Releasing version $new_version"


echo "Updating project verion"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $new_version" $plist


echo "Updating podspec version"
current_version_line=`grep -e "[a-zA-Z\s]*\.version\s*=\s*\"[0-9\.]*\"" "$podspec"`
current_version=$(echo $current_version_line | cut -f2 -d'"')
sed -i .backup "s/$current_version/$new_version/g" $podspec
rm "$podspec.backup"


echo "Creating release commit"
git add --all
git commit -m "Release version $new_version"
git push


echo "Creating tag"
git tag -a $new_version -m $new_version
git push --tags


echo "Validating podspec"
pod spec lint


# TODO: Run intergration tests (kean/Nuke-Integration-Tests)
# TODO: pod trunk push

# In case things go south

# git tag -d $new_version
# git push origin :refs/tags/$new_version
# git reset --hard <#previous_commit#>
# git push --force