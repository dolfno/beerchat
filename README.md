# QA on postgres db to ask beer related questions
Quick and dirty example of usage of OpenAI davinci model using Langchain (https://python.langchain.com/) on top of postgres db.
Put behind api to be used in grafana dashboard.

change .env.example to .env and put your own OPENAI API KEY

## Postgress
Run postgress docker 
`docker-compose -f docker-compose.yml up flyway-reporting`

## Grafana 
see grafana/readme.md