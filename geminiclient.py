# gemini_client.py
from flask import Flask, render_template_string, request
import google.generativeai as genai
import os

# Configure Gemini API
genai.configure(api_key=os.getenv("GEMINI_API_KEY", "AIzaSyDShWjh4UIyAZUWcMZz2j1Zd_FR306BkjM"))

app = Flask(__name__)

HTML = """
<!DOCTYPE html>
<html>
<head>
    <title>Career Advisor AI</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f6f9fc; }
        textarea { width: 100%; height: 100px; }
        button { background: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; }
        button:hover { background: #45a049; }
        .response { background: #fff; padding: 20px; margin-top: 20px; border-radius: 10px; }
    </style>
</head>
<body>
    <h2>🎯 AI Career Advisor</h2>
    <form method="POST">
        <textarea name="prompt" placeholder="Describe your skills, interests, or goals..."></textarea><br><br>
        <button type="submit">Get Career Advice</button>
    </form>
    {% if response %}
    <div class="response">
        <h3>Recommended Career Path:</h3>
        <p>{{ response }}</p>
    </div>
    {% endif %}
</body>
</html>
"""

@app.route("/", methods=["GET", "POST"])
def home():
    response = None
    if request.method == "POST":
        prompt = request.form["prompt"]
        model = genai.GenerativeModel("gemini-1.5-flash")
        reply = model.generate_content(f"Provide career guidance for: {prompt}")
        response = reply.text
    return render_template_string(HTML, response=response)

def start_app():
    app.run(host="0.0.0.0", port=8000, debug=True)