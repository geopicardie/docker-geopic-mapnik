FROM picnat/mapproxy
MAINTAINER Nicolas Damiens <nicolas@damiens.info>
ENV HOME /root
VOLUME ["/srv/inpn","/srv/coastline","/srv/osmdata"]
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys ADE38194313EF4AF
RUN gpg --armor --export ADE38194313EF4AF | apt-key add - 
ADD depot-nico.list /etc/apt/sources.list.d/depot-nico.list
RUN apt-get update; apt-get install -y naturalearth-data fonts-exo
RUN git clone https://github.com/geopicardie/style-osm-geopicardie /srv/style-osm-geopicardie
ENV BRANCH imposm3-mapping
ADD update-style /usr/local/bin/update-style
ADD prod_project_mml.py /usr/local/bin/prod_project_mml
ADD configure /usr/local/bin/configure
ADD run-mapnik /usr/local/bin/run-mapnik
RUN chmod a+rx /usr/local/bin/run-mapnik /usr/local/bin/configure /usr/local/bin/prod_project_mml /usr/local/bin/update-style
EXPOSE 80
CMD ["/usr/local/bin/run-mapnik"]
