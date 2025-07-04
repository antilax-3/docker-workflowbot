FROM antilax3/node

# set version labels
ARG build_date
ARG version
LABEL build_date="${build_date}"
LABEL version="${version}"
LABEL maintainer="Nightah"

# set environment variables
ENV NODE_CONFIG_DIR=/config \
PRIVATE_KEY_PATH=/config/privkey.pem

# set working directory
WORKDIR /app

# copy local files
COPY root/ /

# install packages
RUN \
  echo "**** build node application ****" && \
    cd /app && npm install

# ports and volumes
EXPOSE 3000
VOLUME /config
