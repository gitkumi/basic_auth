# BasicAuth

Basic auth starter.

## Postgres

```sh
docker container rm postgres && docker run --name postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
```
