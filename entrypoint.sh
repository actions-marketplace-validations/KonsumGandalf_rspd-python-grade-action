#!/bin/bash

# Set input parameters
API_URL="${{ inputs.api_url }}"
REPO_URL="${{ inputs.repositoryUrl }}"
REPO_URL="${{ inputs.repository }}"
ACTOR="${{ inputs.actor }}"

# Set up Python
python_version="3.x"
python_setup_cmd="actions/setup-python@v4"
python_setup_input="python-version=$python_version"
python_setup_args="--with=$python_setup_cmd --input=$python_setup_input"
sh -c "$python_setup_args"

# Install dependencies
pip_install_cmd="python -m pip install --upgrade pip"
sh -c "$pip_install_cmd"

# Run tests with pytest
pytest_install_cmd="pip install pytest pytest-cov pytest-json-report"
pytest_run_cmd="pytest --json-report -v"
sh -c "$pytest_install_cmd && $pytest_run_cmd"

CONTENTS=$(cat .report.json)

# Call Backend
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "repositoryUrl": "'"$REPO_URL"'",
    "actor": "'"$ACTOR"'",
    "repository": "'"$REPO"'",
    "submission": "'"$CONTENTS"'"
  }' \
  $API_URL

# Run pytest and output results
pytest $SHORT_FORM > results.txt
echo "::set-output name=results::$(cat results.txt)"