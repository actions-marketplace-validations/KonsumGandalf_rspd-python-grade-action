#!/bin/bash

# Check out the code
git clone https://github.com/your-username/your-repo.git

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
pytest_run_cmd="pytest --json-report -v hello_test.py"
sh -c "$pytest_install_cmd && $pytest_run_cmd"

CONTENTS=$(cat .report.json)

# Call Backend
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "repositoryUrl": "git://github.com/OTH-Digital-Skills/lab-04-mario-angie_123",
    "actor": "angie_123",
    "repository": "OTH-Digital-Skills/lab-04-mario-angie_123",
    "submission": "'"$CONTENTS"'"
  }' \
  $API_URL/submission/github

# Run pytest and output results
pytest $SHORT_FORM > results.txt
echo "::set-output name=results::$(cat results.txt)"