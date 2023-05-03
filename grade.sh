#!/bin/bash

# Set input parameters
API_URL="${{ inputs.api_url }}"
REPO_URL="${{ inputs.repositoryUrl }}"
REPO="${{ inputs.repository }}"
ACTOR="${{ inputs.actor }}"

echo "$API_URL" "$REPO_URL" "$REPO_URL" "$REPO_URL"

curl -X GET $API_URL

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

