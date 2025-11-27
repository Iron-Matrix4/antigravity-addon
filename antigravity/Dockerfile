ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  sudo \
  build-essential \
  libstdc++6 \
  openssl \
  net-tools \
  locales \
  jq \
  && rm -rf /var/lib/apt/lists/*

# Install code-server via official script
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create directory for extensions
RUN mkdir -p /root/.local/share/code-server/extensions

# Install Continue extension from GitHub Releases (latest)
RUN LATEST_URL=$(curl -s https://api.github.com/repos/continuedev/continue/releases/latest | jq -r '.assets[] | select(.name | endswith(".vsix")) | .browser_download_url' | head -n 1) && \
  curl -fL "$LATEST_URL" -o /tmp/continue.vsix && \
  code-server --install-extension /tmp/continue.vsix && \
  rm /tmp/continue.vsix

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /config

CMD ["/bin/bash", "/app/run.sh"]
