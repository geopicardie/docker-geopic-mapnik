## Service http mapnik (fabrication des tuiles)

```
docker build -t geopicstyle-mapnik git://github.com/ndamiens/docker-geopic-mapnik
docker run -d -p 8080:80 --name "geopic-mapnik" --link geopic-postgres-osm:postgres-osm geopicstyle-mapnik
```


