#!/bin/bash

# This script is intende to run from gitlab CI pipeline schedule.
# It runs sphinx to update the pot file and if there are meaningful changes it creates an MR for it.

# Setup:
# Firstly, make sure you have a stage in .gitlab-ci.yml that runs this script with a rule for `$CI_PIPELINE_SOURCE == "schedule"``. Other, normal stages should have a rule for `!= "schedule"`.
# Secondly, create a schedule: Go to Build -> Pipeline schedules -> New Schedule, Give a description and chose a timezone and an interval pattern (e.g. weekly)
# Lastly, make sure the script has appropriate authorization to be able to push and to create merge requests:
# * Go to Settings -> Access tokens -> Add new token
#   * Choose a token name - this will show up as the author of the commit
#   * Select an appropriate expiration date
#   * Select the role *Developer* and give *read_repository* and *write_repository* so the branch can be pushed
#   * Also give *api* access so the MR can be opened
#   * Note: The token cannot be edited later on, so be sure to set everything the first time
# * Copy the project access token and keep it in a safe place
# * Now go to Settings -> CI/CD -> Variables
#   * Add a variable: POT_UPDATE_USER with your user name
#   * Add another variable: POT_UPDATE_TOKEN, make it "masked and hidden" and "protected" and set it to the value of the access token you just created

set -e

BRANCH="auto/update-translations-pot"

TIMESTAMP=$(date +%s)
DATE=$(date -u -Ins -d @${TIMESTAMP})
echo "TIMESTAMP:${TIMESTAMP}" | tee status.txt
echo "DATE:${DATE}" | tee -a status.txt

echo "MOUNT"
mount
echo "PWD:[$(pwd)]"
echo "LS-altr"
ls -altr
echo "GIT-status"
git status
echo "GIT-remote-v"
git remote -v
echo "GIT-branch-avv"
git branch -avv

python -m sphinx -Wa -b gettext . locales/pot

# echo "Fail this job for testing purpuses"
# /bin/false

echo "Determine whether pot file needs to be updated ... "
if diff -q \
    <( git show HEAD:locales/pot/docs.pot | sed 's/^"POT-Creation-Date:.*"$/"POT-Creation-Date: IGNORE"/' ) \
    <( cat locales/pot/docs.pot           | sed 's/^"POT-Creation-Date:.*"$/"POT-Creation-Date: IGNORE"/' ) ;
then
    echo "... no update needed"
    exit 0
else
    echo "... update needed"
fi

echo "Commit pot file ($BRANCH)"
git config user.name "UBports docs repo periodic translation pot updater"
git config user.email "pot.ci.docs.ubports.com@example.com"
git checkout -b "$BRANCH"
git add locales/pot/docs.pot
git commit -m "Automated translations .pot update ${DATE}" || { echo "No changes to commit"; exit 0; }

echo "Push branch (${CI_PROJECT_PATH})"
git push --force "https://${POT_UPDATE_USER}:${POT_UPDATE_TOKEN}@gitlab.com/${CI_PROJECT_PATH}.git" "$BRANCH"

echo "Create merge request ..."
curl --request POST --header "PRIVATE-TOKEN: ${POT_UPDATE_TOKEN}" --header "Content-Type: application/json" \
    "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/merge_requests" --data '{
        "source_branch": "'"${BRANCH}"'",
        "target_branch": "master",
        "title": "Automated translations .pot update",
        "remove_source_branch": true
    }'

echo "Done"
