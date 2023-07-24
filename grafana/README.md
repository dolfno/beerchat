# Grafana docker for local

Build and run the container to validate, e.g.:

```bash
$ cd docker

$ docker build -t grafana:9.5.6-1 .

$ docker run --platform linux/amd64 -p 3000:3000 grafana:9.5.6-1
```

If the container starts, the newly built Grafana is accessible at http://localhost:3000 (Default credentials: `admin`/`admin`)

## Setup datasource connection
* json api connection
* browser connection
* use `host.docker.internal:5432` as host
* create text box varialbe and use that in panel to call api
https://grafana.com/grafana/plugins/simpod-json-datasource/ 