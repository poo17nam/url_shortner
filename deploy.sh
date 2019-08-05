#!/usr/bin/env sh

# abort on errors
set -e

# build
echo Building. this may take a minute...
npm run build

# navigate into the build output directory
cd dist

echo Deploying..
git init
git add -A
git commit -m 'deploy'

git push -f git@github.com:poo17nam/url_shortner.git master:gh-pages

cd -
