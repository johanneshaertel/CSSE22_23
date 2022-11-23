import config, requests, json

header = {"Authorization": "token %s" % config.token}

response = requests.get('https://api.github.com/search/code?q=org.antlr.v4.runtime+extension:java', headers=header)

j = json.loads(response.content)

print(j)
