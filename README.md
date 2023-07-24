# QA on postgres db to ask beer related questions
Quick and dirty example of usage of OpenAI davinci model using Langchain (https://python.langchain.com/) on top of postgres db.
Put behind api to be used in grafana dashboard.

1. change .env.example to .env and put your own OPENAI API KEY
2. start postgres db (run migrations and fill some data)
3. start grafana docker
4. create new venv, install reqs
5. run python hnkreportingchat.py to start api

## Postgress
Run postgress docker 
`docker-compose -f docker-compose.yml up flyway-reporting`

## Grafana 
see grafana/readme.md

https://github.com/dolfno/beerchat/assets/65344169/af10bf30-1269-47dc-bdd6-070c2c1ef0f0

