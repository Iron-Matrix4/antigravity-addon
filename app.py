from flask import Flask, render_template, request, jsonify
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/api/chat', methods=['POST'])
def chat():
    data = request.json
    user_message = data.get('message', '')
    logger.info(f"Received message: {user_message}")
    
    # Mock response for now
    response_text = f"I am AntiGravity. You said: {user_message}"
    
    if "hello" in user_message.lower():
        response_text = "Greetings. I am ready to assist you."
    elif "status" in user_message.lower():
        response_text = "All systems operational. Gravity is nominal."
        
    return jsonify({"response": response_text})

if __name__ == '__main__':
    # Home Assistant addons typically run on port 8099 (mapped) or internal 8099
    # We'll listen on 0.0.0.0 to be accessible from outside the container
    app.run(host='0.0.0.0', port=8099)
