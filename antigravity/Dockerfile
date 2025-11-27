ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache \
  nodejs \
  npm \
  git \
  bash \
  curl \
  sudo \
  build-base \
  python3 \
  py3-pip \
  libc6-compat \
  libstdc++

# Install code-server
RUN npm install -g --unsafe-perm code-server@latest

# Create directory for extensions
RUN mkdir -p /root/.local/share/code-server/extensions

# Install Continue extension
RUN code-server --install-extension Continue.continue

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /config

CMD ["/bin/bash", "/app/run.sh"]
