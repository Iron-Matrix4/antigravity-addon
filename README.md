# AntiGravity Home Assistant Add‑on

## Overview
The **AntiGravity** add‑on provides a full **VS Code environment** in your browser with **Gemini AI assistant** integration. Edit your Home Assistant configuration files while chatting with Gemini for help and code suggestions.

## Features
- **Full VS Code IDE** running in browser via code-server
- **Gemini Code Assist** extension pre-installed for AI chat and code suggestions
- Direct access to Home Assistant `/config` directory for editing
- Dark VS Code theme with file explorer, terminal, and extensions
- Gemini chat panel on the right side (just like https://antigravity.google/)

## Installation
1. **Add Repository** in Home Assistant:
   - Go to **Settings → Add-ons → Add-on Store** (three dots) → **Repositories**
   - Add: `https://github.com/Iron-Matrix4/antigravity-addon`
2. **Install AntiGravity** from the add-on store
3. **Configure**:
   - Set a `password` for code-server access
   - Set your `api_key` from [Google AI Studio](https://aistudio.google.com/app/apikey)
4. **Start** the add-on
5. **Open Web UI** to access VS Code

## Usage
- **File Explorer**: Browse and edit your Home Assistant config files on the left
- **Editor**: Make changes to YAML, automations, scripts in the center
- **Gemini Chat**: Click the chat icon or use the command palette to open Gemini on the right
- **Terminal**: Access Home Assistant's terminal from the bottom panel

## Screenshots
![VS Code with Gemini Chat](https://raw.githubusercontent.com/Iron-Matrix4/antigravity-addon/main/screenshot.png)

---
*Created by the AntiGravity Gemini Integration project.*
