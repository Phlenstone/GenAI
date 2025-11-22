🎯 AI Career Advisor (Jac + Gemini + Flask)

This is an intelligent **career guidance assistant** built using **Jac language**, **Flask**, and **Google Gemini AI**.  
It analyzes your skills, goals, and background to recommend suitable career paths — and stores user insights locally using SQLite.

---

## 🧠 Features

- 💬 AI-powered career recommendations via Gemini API  
- 🧱 Modular architecture (Jac for logic, Flask for API, SQLite for persistence)  
- 🔐 Local database for saving user career history  
- ⚡ Easy setup and lightweight dependencies  
- 🧩 Extendable for more ML or NLP integrations  

---

## 📁 Project Structure

jac_projects/
│
├── career_advisor_web.jac # Main Jac logic & AI integration
├── gemini_client.py # Gemini API interaction (text-based AI)
├── db_manager.py # Database manager using SQLite
├── .gitignore
└── README.md

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/Phlenstone/GenAI
cd carreer
2️⃣ Create and Activate a Virtual Environment
bash
Copy code
python -m venv .venv
.venv\Scripts\activate    # On Windows
source .venv/bin/activate # On Linux/Mac
3️⃣ Install Dependencies
bash
Copy code
pip install -r requirements.txt
If you don’t have a requirements.txt yet, create one with:

nginx
Copy code
flask
jac-lang
google-generativeai
4️⃣ Run the App
bash
Copy code
jac run career_advisor_web.jac
or (for Flask-based version)

bash
Copy code
python app.py
Then open in browser:

arduino
Copy code
http://localhost:5000
🧩 How It Works
User Input: Enter your skills, education, and interests.

Jac Logic: Processes data and prepares structured insights.

Gemini API: Generates personalized career guidance.

SQLite DB: Saves previous queries and recommendations for analysis.

🧠 Example Prompt
text
Copy code
"I have a degree in IT and experience in customer support. What career paths fit me best?"
Output:

Based on your skills in IT and communication, you could explore:

UX/UI Design

Technical Support Engineering

IT Project Coordination

AI Chatbot Integration Roles

🧑‍💻 Author
Misheck Musau Kamuya
💼 IT Support Team Lead | AI & Automation Enthusiast
📍 Nairobi, Kenya
📧 misheckamuya@gmail.com

⭐ Contribute
Pull requests and suggestions are welcome!
If you like this project, give it a ⭐ on GitHub to support it.

🛠️ License
This project is licensed under the MIT License — feel free to use and adapt it.

Built with 💡 by Misheck Musau Kamuya — inspired by a passion for AI & career innovation.# GenAI