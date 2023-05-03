echo "$API_URL" "$REPO_URL" "$REPO" "$ACTOR"

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

# Call API to submit report
curl -X POST \
  -H "Content-Type: application/json" \
  -F submission=$CONTENTS \
  -F repositoryUrl=$REPO_URL \
  -F actor=$ACTOR \
  -F repository=$REPO \
  $API_URL
