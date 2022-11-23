import requests
import json

user = "docker"
repo = "awesome-compose"

url = "https://api.github.com/repos/" + user + "/" + repo

r = requests.get(url)

data = json.loads(r.content)

popularity = data["stargazers_count"]

print(popularity)

# PRO
# - Simple way to access metadata.
# CON
# - Limited to the GitHub API core Interface
# - Limited by ‘Rate Limit’
# - No complex queries are possible
# - No resources