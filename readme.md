## R-project packages indexer and API

Indexer runs daily at 12 am importing r packages information from a certain cran server and persisting it into the database for later consumtion via API.

## Prerequisites

**Docker-compose**

## Run the service
Using docker compose:
 ```
 $ docker-compose up --build
 ```

* start service API server with CRON. The server is listening to host and port: localhost:80
* start api console (API documentation and console to try out the service). you can access it via localhost:9000
* start a DB service

## Run import task manually for testing

* after you run the service. Please, ssh the docker container and run

```
$ docker exec -it #{replace with container id} bin/rake general:import_packages -- -s 'http://cran.r-project.org/src/contrib/' -p 'PACKAGES' -t '{server_dir}{package_name}_{package_version}.tar.gz' -d 'DESCRIPTION' -l 5
```

* Now, access the API via a web browser or test via the API console (make sure to get the CORS fixed https://github.com/mulesoft/api-console#cors)

## Run the specs
Using docker compose:
 ```
 $ docker-compose --file docker-compose-test.yml run --rm service-test
 ```

## Missing

- [ ] proper error handling and reporting
- [ ] lib tests
- [ ] end to end tests (probably utilizing cucumber)
- [ ] cache gems in passenger.Dockerfile
- [ ] TODOs
