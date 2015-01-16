## Service http mapnik (fabrication des tuiles)

```
docker build -t geopicstyle-mapnik git://github.com/ndamiens/docker-geopic-mapnik
docker run -d -p 8080:80 --name "geopic-mapnik" --link geopic-postgres-osm:postgres_osm geopicstyle-mapnik
```

Pour travailler sur le style on peut préciser un "volume" pour le répertoire où se trouve le style dans le conteneur au lancement. Il faut remplacer /home/login/style-osm-geopicardie par le chemin où se trouve le dépôt git du style.

Pour mettre à jour stopper et relancer le conteneur en réutilisant la ligne de commande.

```
docker rm -f "geopic-mapnik" ; docker run -d -p 8080:80 --name "geopic-mapnik" --link geopic-postgres-osm:postgres_osm -v /home/login/style-osm-geopicardie:/srv/style-osm-geopicardie geopicstyle-mapnik
```

Configurer le conteneur pour un autre style que celui par défaut (-e STYLE=autrestyle)

```
docker rm -f "geopic-mapnik" ; docker run -d -e STYLE=naturaliste -p 8080:80 --name "geopic-mapnik" --link geopic-postgres-osm:postgres_osm -v $HOME/docker/style-osm-geopicardie:/srv/style-osm-geopicardie geopicstyle-mapnik; docker logs -f geopic-mapnik
```

Pour mettre à jour le dépot git des styles ajouter -e GITPULL=yes
