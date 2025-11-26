ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache \
  nodejs \
  npm \
  git \
  bash \
  curl \
  sudo

# Install code-server
RUN npm install -g --unsafe-perm code-server@latest

# Create directory for extensions
RUN mkdir -p /root/.local/share/code-server/extensions

# Download and install Gemini Code Assist extension
# Using the official extension from Open VSX
RUN curl -fsSL https://open-vsx.org/api/GoogleCloudTools/gemini-code-assist/0.0.1/file/GoogleCloudTools.gemini-code-assist-0.0.1.vsix \
  -o /tmp/gemini.vsix || true

# If download succeeded, install it
RUN if [ -f /tmp/gemini.vsix ]; then \
  code-server --install-extension /tmp/gemini.vsix; \
  fi

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

WORKDIR /config

CMD ["/bin/bash", "/app/run.sh"]
