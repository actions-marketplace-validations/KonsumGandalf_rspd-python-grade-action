#!/bin/bash

# Set input parameters
API_URL="http://host.docker.internal:3000/api/submission/github"
REPO_URL="OTH-Digital-Skills/lab-04-mario-angie_123"
REPO="OTH-Digital-Skills/lab-04-mario-angie_123"
ACTOR="OTH-Digital-Skills/lab-04-mario-angie_123"

echo "$API_URL" "$REPO_URL" "$REPO_URL" "$REPO_URL"

curl -X GET http://host.docker.internal:3000/api/submission/github

sudo apt-get update
apt-get install -y python3-pip

# Install packages with pip
pip3 install pytest pytest-cov pytest-json-report requests
python -m pytest --json-report -v --tb=line --json-report-indent=2

pip3 install pytest pytest-cov pytest-json-report

cat .report.json | tr -d '\r\n' | sed 's/[^[:print:]]//g' > .report.json

CONTENTS=$(cat .report.json)

#python python_parse.py API_URL REPO_URL REPO ACTOR CONTENTS
echo "$CONTENTS"

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "repositoryUrl": "'"$REPO_URL"'",
    "actor": "'"$ACTOR"'",
    "repository": "'"$REPO"'",
    "submission": "'"$CONTENTS"'"
  }' \
  $API_URL

