walker start_web {
    can start entry {
        web.html("""
        <div class="flex flex-col items-center justify-center min-h-screen bg-gradient-to-r from-indigo-100 to-blue-200 p-6">
            <h1 class="text-3xl font-bold mb-6 text-gray-800">💼 Smart Career Advisor</h1>
            <div id="register" class="bg-white shadow-xl rounded-2xl p-6 w-full max-w-lg mb-6">
                <h2 class="text-xl font-semibold mb-2">Register / Log In</h2>
                <input id="name" class="w-full p-2 border rounded mb-2" placeholder="Your Name">
                <input id="skills" class="w-full p-2 border rounded mb-2" placeholder="Your Skills (e.g., IT, design)">
                <input id="goals" class="w-full p-2 border rounded mb-3" placeholder="Your Career Goals">
                <button onclick="registerUser()" class="bg-blue-600 hover:bg-blue-700 text-white py-2 px-4 rounded w-full">Save Profile</button>
            </div>

            <div id="chat" class="bg-white shadow-xl rounded-2xl p-6 w-full max-w-lg hidden">
                <p class="text-gray-700 mb-3">Ask for career guidance:</p>
                <textarea id="userInput" class="w-full p-2 border rounded mb-3 h-24" placeholder="e.g., What jobs fit my skills in AI and design?"></textarea>
                <button onclick="sendQuery()" class="bg-green-600 hover:bg-green-700 text-white py-2 px-4 rounded">Get Advice</button>
                <pre id="output" class="mt-4 p-3 bg-gray-50 border rounded text-gray-800 whitespace-pre-wrap"></pre>
            </div>
        </div>

        <script>
        async function registerUser() {
            const name = document.getElementById('name').value;
            const skills = document.getElementById('skills').value;
            const goals = document.getElementById('goals').value;
            const res = await fetch('/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name, skills, goals })
            });
            const data = await res.json();
            if (data.success) {
                alert('Welcome, ' + name + '! You can now chat.');
                document.getElementById('register').style.display = 'none';
                document.getElementById('chat').style.display = 'block';
                localStorage.setItem('username', name);
            } else {
                alert('Welcome back, ' + name + '!');
                document.getElementById('register').style.display = 'none';
                document.getElementById('chat').style.display = 'block';
                localStorage.setItem('username', name);
            }
        }

        async function sendQuery() {
            const text = document.getElementById('userInput').value;
            const name = localStorage.getItem('username');
            const res = await fetch('/career', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ text, name })
            });
            const data = await res.json();
            document.getElementById('output').textContent = data.advice;
        }
        </script>
        """)
    }
}

walker register_user {
    has name, skills, goals;

    can run entry {
        if (!name) {
            web.json({"success": false, "message": "Missing name"});
            return;
        }
        ok = python.call("db_manager.register_user", name, skills, goals);
        web.json({"success": ok});
    }
}

walker career_advice {
    has name, text;

    can run entry {
        user = python.call("db_manager.get_user", name);
        if (!user) {
            web.json({"advice": "User not found. Please register first."});
            return;
        }
        report "Fetching personalized advice...";
        advice = python.call("gemini_client.get_career_advice", text);
        python.call("db_manager.save_chat", user[0], text, advice);
        web.json({"advice": advice});
    }
}

service web {
    routes: {
        "/": start_web,
        "/register": register_user,
        "/career": career_advice
    }
}