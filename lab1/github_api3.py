import requests
import json

# https://docs.github.com/en/rest/search#search-repositories

term = "tetris"

url = "https://api.github.com/search/repositories?q="+ term +"&sort=stars&order=desc"

r = requests.get(url)

data = json.loads(r.content)

for item in data["items"]:
    print(item["full_name"])

