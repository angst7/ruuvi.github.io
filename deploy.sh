#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# go to the out directory and create a *new* Git repo

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "test@test.com"

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
rm .gitignore
git add .
git commit -am "Deploy to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push https://${GH_TOKEN}@github.com/ruuvi/ruuvi.github.io.git :master > /dev/null 2>&1
git subtree push --prefix build https://${GH_TOKEN}@github.com/ruuvi/ruuvi.github.io.git master > /dev/null 2>&1
