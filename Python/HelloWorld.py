import requests
import json

api_url="https://archive-api.open-meteo.com/v1/archive?latitude=41.4139&longitude=2.0158&start_date=2023-12-01&end_date=2023-12-31&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=Europe%2FBerlin"

response=requests.get(api_url)

dades=json.loads(response.text)
print(json.dumps(dades,indent=3))