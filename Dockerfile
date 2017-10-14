FROM openjdk:8-jre

# Enable HTTPS apt sources
RUN apt-get update
RUN apt-get install -y apt-transport-https

###############################################################################
# Initialise users
###############################################################################

RUN useradd -c 'Sally the senior tutor' -m -d /home/sally -s /bin/bash sally
RUN useradd -c 'Lovelace account' -m -d /home/lovelace -s /bin/bash lovelace

###############################################################################
# Install Scala
###############################################################################

# Install Scala build tool. (Version is underdetermined.)
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update
RUN apt-get install -y sbt
# Fetch any missing SBT first-time run requirements
RUN sbt about

###############################################################################
# Initialise the Training database
###############################################################################

RUN apt-get install -y \
  postgresql-9.6 \
  libdatetime-perl \
  libdbd-pg-perl \
  libfile-mmagic-perl \
  liblockfile-simple-perl \
  libtext-wrapi18n-perl

# Run train startup scripts
ARG TRAIN_DIR
ADD $TRAIN_DIR/utils /usr/local/train/utils
ADD $TRAIN_DIR/specs /usr/local/train/specs
ENV PATH="/usr/local/train/utils:${PATH}"
USER postgres
ADD init_psql.sh /tmp/
RUN /tmp/init_psql.sh
USER root

###############################################################################
# Judge utils
###############################################################################

ARG JUDGE_DIR
ADD $JUDGE_DIR /usr/local/judge
ENV PATH="/usr/local/judge:${PATH}"

###############################################################################
# Make the shell experience friendly
###############################################################################

COPY path-extras.sh /etc/profile.d/path-extras.sh
RUN chmod a+x /etc/profile.d/path-extras.sh

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
WORKDIR "/home/lovelace"
