#!/usr/bin/env bashio

# Get configuration
PASSWORD=$(bashio::config 'password')
API_KEY=$(bashio::config 'api_key')

# Set Gemini API key as environment variable
export GEMINI_API_KEY="$API_KEY"

# Create code-server config directory
mkdir -p /root/.config/code-server

# Write code-server config
cat > /root/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:8080
auth: password
password: ${PASSWORD}
cert: false
EOF

# Create user settings for Gemini extension
mkdir -p /root/.local/share/code-server/User
cat > /root/.local/share/code-server/User/settings.json <<EOF
{
  "gemini.apiKey": "${API_KEY}",
  "workbench.colorTheme": "Default Dark+",
  "editor.fontSize": 14,
  "terminal.integrated.fontSize": 14
}
EOF

bashio::log.info "Starting code-server on port 8080..."
bashio::log.info "Password authentication is enabled"

# Launch code-server
exec code-server /config
