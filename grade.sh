echo "$API_URL" "$REPO_URL" "$REPO" "$ACTOR"


curl -X GET $API_URL



sudo apt-get update
apt-get install -y python3-pip

# Install packages with pip
pip3 install pytest pytest-cov pytest-json-report requests

# Generate JSON report
python -m pytest --json-report -v --tb=line --json-report-indent=2

# Remove non-printable characters from report
cat .report.json | tr -d '\r\n' | sed 's/[^[:print:]]//g' > .report_clean.json

CONTENTS=$(cat .report_clean.json)
echo "$CONTENTS"

echo '{
    "repositoryUrl": "'"$REPO_URL"'",
    "actor": "'"$ACTOR"'",
    "repository": "'"$REPO"'",
    "submission": "'"$CONTENTS"'"
}' > .submission.json

TEST=$(cat .submission.json)
echo "$TEST"


curl -v -X POST \
  -H "Content-Type: multipart/form-data" \
  -F "data=@submission.json" \
  $API_URL

# Call API to submit report

