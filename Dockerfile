FROM picnat/mapproxy
MAINTAINER Nicolas Damiens <nicolas@damiens.info>
ENV HOME /root
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys ADE38194313EF4AF
RUN gpg --armor --export ADE38194313EF4AF | apt-key add - 
ADD depot-nico.list /etc/apt/sources.list.d/depot-nico.list
RUN apt-get update; apt-get install -y naturalearth-data fonts-exo
RUN git clone https://github.com/bchartier/style-osm-geopicardie /srv/style-osm-geopicardie
ENV BRANCH imposm3-mapping
ADD update-style /usr/local/bin/update-style
RUN wget -O /tmp/coastline.zip http://nicolas.damiens.info/coastline-good.zip
RUN mkdir /srv/coastline/; cd /srv/coastline; unzip /tmp/coastline.zip; rm /tmp/coastline.zip
RUN mkdir /srv/inpn;
RUN wget -O /srv/inpn/l93_5k.zip http://inpn.mnhn.fr/docs/Shape/L93_5K.zip
RUN wget -O /srv/inpn/l93_10k.zip http://inpn.mnhn.fr/docs/Shape/L93_10K.zip
RUN cd /srv/inpn/; unzip l93_5k.zip; unzip l93_10k.zip; rm *.zip
ADD prod_project_mml.py /usr/local/bin/prod_project_mml
ADD configure /root/configure
RUN /bin/bash /root/configure
EXPOSE 80
CMD ["/usr/local/bin/run"]
