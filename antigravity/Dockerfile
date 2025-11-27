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
  libstdc++ \
  openssl

# Install code-server via release binary
ARG CODE_SERVER_VERSION=4.106.2
RUN ARCH=$(uname -m) && \
  if [ "$ARCH" = "x86_64" ]; then \
  CS_ARCH="amd64"; \
  elif [ "$ARCH" = "aarch64" ]; then \
  CS_ARCH="arm64"; \
  elif [ "$ARCH" = "armv7l" ]; then \
  CS_ARCH="armv7l"; \
  else \
  echo "Unsupported architecture: $ARCH"; exit 1; \
  fi && \
  curl -fOL "https://github.com/coder/code-server/releases/download/v$CODE_SERVER_VERSION/code-server-$CODE_SERVER_VERSION-linux-$CS_ARCH.tar.gz" && \
  tar -xzf "code-server-$CODE_SERVER_VERSION-linux-$CS_ARCH.tar.gz" && \
  mv "code-server-$CODE_SERVER_VERSION-linux-$CS_ARCH" /usr/lib/code-server && \
  ln -s /usr/lib/code-server/bin/code-server /usr/bin/code-server && \
  rm "code-server-$CODE_SERVER_VERSION-linux-$CS_ARCH.tar.gz"

# Create directory for extensions
RUN mkdir -p /root/.local/share/code-server/extensions

# Install Continue extension
RUN code-server --install-extension Continue.continue

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /config

CMD ["/bin/bash", "/app/run.sh"]
