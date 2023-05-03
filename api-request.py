import json
import requests

# Read report data from .report.json file
with open('.report.json', 'r') as f:
    report_data = json.load(f)

# Read submission data from .submission.json file
with open('.submission.json', 'r') as f:
    submission_data = json.load(f)

# Extract required data from submission_data
repositoryUrl = submission_data[0]['repositoryUrl']
actor = submission_data[0]['actor']
repository = submission_data[0]['repository']
submission = submission_data[0]['submission']

# Create dictionary with extracted data
data = {
    'repositoryUrl': repositoryUrl,
    'actor': actor,
    'repository': repository,
    'submission': submission
}

# Convert dictionary to JSON string
json_data = json.dumps(data)

# Send POST request to API_URL with JSON data
response = requests.post(API_URL, json=data)

# Print response status code and content
print(response.status_code)
print(response.content)
