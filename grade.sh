echo "$API_URL" "$REPO_URL" "$REPO" "$ACTOR"


curl -X GET $API_URL



sudo apt-get update
apt-get install -y python3-pip

# Install packages with pip
pip3 install pytest pytest-cov pytest-json-report requests

# Generate JSON report
python -m pytest --json-report -v --json-report-indent=2

# Remove non-printable characters from report
# cat .report.json | tr -d '\r\n' | sed 's/[^[:print:]]//g; s|[\\/]||g' > .report_clean.json



#echo '{
#    "repositoryUrl": "'"$REPO_URL"'",
#    "actor": "'"$ACTOR"'",
#    "repository": "'"$REPO"'",
#    "submission": "'"$CONTENTS"'"
#}' > .submission.json
#
#TEST=$(cat .submission.json)
#echo "$TEST"
#
#
#curl -v -X POST "Content-Type: application/json" -d @.submission.json $API_URL
#cat .submission.json | jq -s '.[0] | {repositoryUrl, actor, repository, submission}'
#
#cat .submission.json | jq -s '.[0] | {repositoryUrl, actor, repository, submission}' | curl -v -X POST "Content-Type: application/json" -d @- $API_URL

PAYLOAD=$(python -m pytest --json-report | jq -n --arg repoUrl "$REPO_URL" --arg actor "$ACTOR" --arg repo "$REPO" --arg contents "$(jq .)" '{repositoryUrl: $repoUrl, actor: $actor, repository: $repo, submission: $contents}')

# Send POST request with payload
echo "$PAYLOAD" | curl -v -X POST -H "Content-Type: application/json" -d @- "$API_URL"

# Call API to submit report

