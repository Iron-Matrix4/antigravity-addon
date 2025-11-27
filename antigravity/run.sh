#!/usr/bin/env bashio

# Get configuration
PASSWORD=$(bashio::config 'password')
API_KEY=$(bashio::config 'api_key')

# Set Gemini API key as environment variable
export GEMINI_API_KEY="$API_KEY"
export PASSWORD="$PASSWORD"

# Create user settings directory
mkdir -p /root/.local/share/code-server/User

# Write VS Code settings
cat > /root/.local/share/code-server/User/settings.json <<EOF
{
  "workbench.colorTheme": "Default Dark+",
  "editor.fontSize": 14,
  "terminal.integrated.fontSize": 14
}
EOF

# Configure Continue extension
mkdir -p /root/.continue
cat > /root/.continue/config.json <<EOF
{
  "models": [
    {
      "title": "Gemini 1.5 Flash",
      "provider": "gemini",
      "model": "gemini-1.5-flash",
      "apiKey": "${API_KEY}"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Gemini 1.5 Flash",
    "provider": "gemini",
    "model": "gemini-1.5-flash",
    "apiKey": "${API_KEY}"
  },
  "allowAnonymousTelemetry": false
}
EOF

# Remove any existing config file to prevent conflicts
rm -f /root/.config/code-server/config.yaml

bashio::log.info "Starting code-server..."
bashio::log.info "Bind address: 0.0.0.0:8080"
bashio::log.info "Password length: ${#PASSWORD}"

if [ -z "$PASSWORD" ]; then
    bashio::log.warning "Password is empty. Disabling authentication!"
    AUTH_METHOD="none"
else
    bashio::log.info "Auth method: password"
    AUTH_METHOD="password"
fi

# Launch code-server with CLI flags
# --user-data-dir to ensure settings are persisted/loaded correctly
# --extensions-dir to ensure extensions are found
# We explicitly pass the environment variable in the exec line to be absolutely sure
exec env PASSWORD="$PASSWORD" code-server \
  --bind-addr 0.0.0.0:8080 \
  --auth "$AUTH_METHOD" \
  --user-data-dir /root/.local/share/code-server \
  --extensions-dir /root/.local/share/code-server/extensions \
  /config
