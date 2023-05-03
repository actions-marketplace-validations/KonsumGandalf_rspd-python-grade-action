echo "$API_URL" "$REPO_URL" "$REPO" "$ACTOR"

curl -X GET $API_URL


# Generate JSON report
python -m pytest --json-report -v --json-report-indent=2



#CONTENTS=$(cat .report.json | jq .)
#
#cat .submission.json | jq -s '.[0] | {repositoryUrl, actor, repository, submission}'
#
#cat .submission.json | jq -s '.[0] | {repositoryUrl, actor, repository, submission}' | curl -v -X POST "Content-Type: application/json" -d @- $API_URL

# Call API to submit report

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
