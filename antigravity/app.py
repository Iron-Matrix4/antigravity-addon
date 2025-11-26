from flask import Flask, render_template, request, jsonify
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

import os
import json
import google.generativeai as genai

# Load options from Home Assistant
OPTIONS_PATH = '/data/options.json'
try:
    with open(OPTIONS_PATH, 'r') as f:
        options = json.load(f)
        api_key = options.get('api_key')
except FileNotFoundError:
    api_key = os.environ.get('API_KEY') # Fallback for local testing

if api_key:
    genai.configure(api_key=api_key)
    try:
        logger.info("Listing available models...")
        for m in genai.list_models():
            logger.info(f"Found model: {m.name}")
            if 'generateContent' in m.supported_generation_methods:
                logger.info(f"  - Supports generateContent: {m.name}")
    except Exception as e:
        logger.error(f"Failed to list models: {e}")

    model = genai.GenerativeModel('gemini-1.5-flash')
else:
    logger.warning("No API Key found. Agent will be disabled.")
    model = None

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    data = request.json
    user_message = data.get('message', '')
    logger.info(f"Received message: {user_message}")
    
    if not model:
        return jsonify({"response": "Error: API Key not configured. Please check the add-on configuration."})

    try:
        response = model.generate_content(user_message)
        response_text = response.text
    except Exception as e:
        logger.error(f"Gemini API Error: {e}")
        response_text = f"I encountered an error communicating with the gravity well: {str(e)}"
        
    return jsonify({"response": response_text})

if __name__ == '__main__':
    # Home Assistant addons typically run on port 8099 (mapped) or internal 8099
    # We'll listen on 0.0.0.0 to be accessible from outside the container
    app.run(host='0.0.0.0', port=8099)
