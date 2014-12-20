FROM ubuntu:trusty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y locales && localedef -i fr_FR -c -f UTF-8 -A /usr/share/locale/locale.alias fr_FR.UTF-8

RUN apt-get install -y node-carto apache2 python-dev python-pyproj python-pil python-pip libapache2-mod-wsgi libjpeg-dev zlib1g-dev libyaml-dev gnupg python python-mapnik apache2 python-dev  python-pyproj python-pil python-pip libapache2-mod-wsgi python-pyproj python-pil python-pip libapache2-mod-wsgi libjpeg-dev zlib1g-dev libyaml-dev wget unzip git
ENV HOME /root
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys ADE38194313EF4AF
RUN gpg --armor --export ADE38194313EF4AF | apt-key add - 
ADD depot-nico.list /etc/apt/sources.list.d/depot-nico.list
RUN apt-get update; apt-get install -y naturalearth-data fonts-exo
RUN git clone https://github.com/bchartier/style-osm-geopicardie /srv/style-osm-geopicardie
ENV BRANCH docker
ADD update-style /usr/local/bin/update-style
RUN a2enmod wsgi
RUN pip install MapProxy
RUN useradd -d /srv/mapproxy mapproxy
RUN wget -O /tmp/coastline.zip http://nicolas.damiens.info/coastline-good.zip
RUN mkdir /srv/coastline/; cd /srv/coastline; unzip /tmp/coastline.zip; rm /tmp/coastline.zip
ADD prod_project_mml.py /usr/local/bin/prod_project_mml
ADD run /usr/local/bin/run
EXPOSE 80
CMD ["/usr/local/bin/run"]
