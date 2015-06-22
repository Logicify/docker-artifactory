FROM corvis/java8
MAINTAINER Dmitry Berezovsky <dmitry.berezovsky@logicify.com>

ENV ARTIFACTORY_HOME /srv/artifactory
ENV ARTIFACTORY_VERSION 3.9.0

USER app
WORKDIR ${ARTIFACTORY_HOME}

RUN cd /srv \
  && wget https://bintray.com/artifact/download/jfrog/artifactory/artifactory-${ARTIFACTORY_VERSION}.zip \
  && unzip artifactory-${ARTIFACTORY_VERSION}.zip \
  && rm -f artifactory-${ARTIFACTORY_VERSION}.zip \
  && ln -s artifactory-${ARTIFACTORY_VERSION} ${ARTIFACTORY_HOME} \  
;

RUN curl -o ${ARTIFACTORY_HOME}/tomcat/lib/postgresql-9.4-1201.jdbc41.jar -L https://jdbc.postgresql.org/download/postgresql-9.4-1201.jdbc41.jar \
;

COPY ./etc ${ARTIFACTORY_HOME}/etc
ADD run-artifactory.sh /usr/bin/

CMD /usr/bin/run-artifactory.sh
