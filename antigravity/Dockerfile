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
  && rm -rf /var/lib/apt/lists/*

# Install code-server via official script
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create directory for extensions
RUN mkdir -p /root/.local/share/code-server/extensions

# Install Continue extension from VS Code Marketplace (v1.3.24)
RUN curl -fL "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/Continue/vsextensions/continue/1.3.24/vspackage" -o /tmp/continue.vsix && \
  code-server --install-extension /tmp/continue.vsix && \
  rm /tmp/continue.vsix

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /config

CMD ["/bin/bash", "/app/run.sh"]
