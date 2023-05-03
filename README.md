# rspd-send-report
This action automatically grades submitted `python`code, the results are send to the provide api by curl.

# Features
- Added api_url to allow for customization of the API endpoint.
- Added ability to pass in `repositoryUrl`, `repository ` and `actor` parameters 

# Usage
Below is an example how to use the workflow
```yaml
- name: Execute Tests and Send Report
  uses: KonsumGandalf/rspd-python-grade-action@v1
  with:
    api_url: 'http://example-api.com/submission/github'
    repositoryUrl: 'git://github.com/OTH-Digital-Skills/lab-04-mario-angie_123'
    actor: 'angie_123'
    repository: 'OTH-Digital-Skills/lab-04-mario-angie_123'

```