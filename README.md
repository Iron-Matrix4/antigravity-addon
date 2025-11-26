# AntiGravity Home Assistant Add‑on

## Overview
The **AntiGravity** add‑on provides a sleek, VS Code‑styled chat interface that runs inside Home Assistant. It uses the Google Gemini API to power an AI assistant you can talk to directly from the Home Assistant UI.

## Features
- Dark VS Code‑inspired layout (activity bar, title bar, editor‑style chat area).
- Real‑time Gemini responses via the `/api/chat` Flask endpoint.
- Configurable `api_key` option in the add‑on settings.
- Simple installation as a local Home Assistant add‑on.

## Installation
1. **Copy the add‑on folder**
   ```
   cp -r d:/AntiGravity $HOME/.homeassistant/addons/antigravity
   ```
2. **Add‑on Store** – Ensure the repository is recognized by Home Assistant. The `repository.json` at the repository root points to this add‑on.
3. **Open Home Assistant** → **Settings → Add‑ons → Add‑on Store** → click the three‑dot menu → **Check for updates**. You should see **AntiGravity** under *Local Add‑ons*.
4. **Install** → **Start** the add‑on.
5. **Configure API key**
   - In the add‑on configuration page, paste your Gemini API key into the `api_key` field and save.
6. **Open Web UI** – Click **Open Web UI** to launch the VS Code‑styled chat interface.

## Usage
- Type a message in the input box at the bottom and press **Enter** or click **Send**.
- The assistant will reply using the Gemini model (`gemini‑flash‑latest`).

## Development
- **Frontend** – `antigravity/templates/index.html` contains the VS Code‑style HTML/CSS.
- **Backend** – `antigravity/app.py` handles the Flask server and Gemini API calls.
- **Docker** – `antigravity/Dockerfile` builds the container with Python 3.11‑alpine, Flask, and `google‑generativeai`.

## Screenshots
> *(Add a screenshot of the UI here once you have it running)*

---
*Created by the AntiGravity Gemini Integration project.*
