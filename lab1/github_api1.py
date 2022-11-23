import requests

# https://stackoverflow.com/questions/2751227/how-to-download-source-in-zip-format-from-github

user = "topleet"
repo = "MSR2022"

url = "https://github.com/" + user + "/" + repo + "/archive/master.zip"

r = requests.get(url)

with open("data/repository.zip", "wb") as f:
    f.write(r.content)

# PRO:
# - Simple way to access the full repository content.

# CON:
# - Only the most recent snapshot
# - No information on, changes, commits or authorship.
# - No metadata (pulls or stars)