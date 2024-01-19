FROM python:3.8-bookworm@sha256:9c7e79fb6ee130af5c0be2e3dea04cb6537891e9d398b1d120586110bdc58731

WORKDIR /src

ENV NODE_MAJOR 18
# Install Node.js
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --no-tty --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install nodejs npm net-tools --no-install-recommends -y && \
    npm install -g yarn && \
    node --version && \
    npm --version && \
    yarn --version

COPY frontend/package.json frontend/yarn.lock ./src/
RUN yarn install --production=false

CMD [ "yarn", "dev", "--host", "0.0.0.0" ]
