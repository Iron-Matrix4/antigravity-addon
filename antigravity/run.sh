#!/usr/bin/env bashio

# Get configuration
PASSWORD=$(bashio::config 'password')
API_KEY=$(bashio::config 'api_key')

# Set Gemini API key as environment variable
export GEMINI_API_KEY="$API_KEY"
export PASSWORD="$PASSWORD"

# Create code-server config directory
mkdir -p /root/.config/code-server

# Write code-server config
cat > /root/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:8080
auth: password
cert: false
EOF

# Create user settings for VS Code
mkdir -p /root/.local/share/code-server/User
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

bashio::log.info "Starting code-server on port 8080..."
bashio::log.info "Password authentication is enabled"

# Launch code-server
exec code-server /config
