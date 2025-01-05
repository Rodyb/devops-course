## persist data
- create a named volume in the bottom of the docker compose
``volumes:
  db-data ``
- use it in the docker compose file:
``db-data:/var/lib/mysql/data``
- the volume will now store the changes after closing the containers


