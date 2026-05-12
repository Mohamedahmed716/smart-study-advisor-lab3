# Smart Study Advisor

A multi-paradigm intelligent course recommendation system that provides personalized study paths by evaluating a student's current level, interests, and completed courses. It features two distinct recommendation engines: a strict **Prolog Inference Engine** and a probabilistic **Llama 3.3 AI Agent**.

---

## System Architecture & The Paradigms Blender

This project satisfies the "Paradigms Blender" requirement by explicitly utilizing different programming paradigms where they shine best:

* **Logic Programming (Prolog):** The core reasoning engine. It enforces strict rules, evaluating prerequisite chains and difficulty matrices to ensure students are only recommended courses they are eligible for.
* **Object-Oriented Programming (OOP):** Utilized in the Django backend architecture (Class-Based Views) and React Native component structuring.
* **Imperative Programming:** Manages the sequential execution flow in Python, coordinating data extraction, API requests, and fallback error handling.
* **Functional Programming:** Applied during data transformation, cleanly mapping raw Prolog assertions and AI JSON outputs into the final arrays consumed by the mobile frontend.

---

## Features

* **Dual-Engine Processing:** Seamlessly toggle between the strict Prolog Logic Engine and the conversational Groq AI Agent.
* **Dynamic Rule Enforcement:** Prolog prevents advanced courses from being recommended to beginners and enforces prerequisite completion.
* **AI Insights:** The generative AI agent (Llama 3) finds cross-domain connections (e.g., linking math to graphics) and explains *why* a course fits the user.
* **Native Mobile UI:** Built with React Native and Expo, featuring an intuitive chip-selection interface and locked Dark Mode.

---

## Tech Stack

* **Frontend:** React Native, Expo, Axios
* **Backend:** Python, Django REST Framework
* **Logic Engine:** SWI-Prolog, `pyswip`
* **AI Integration:** Groq API (Llama 3.3 70B Versatile)

---

## Prerequisites

Before running this project, ensure you have the following installed:
1.  **Node.js & npm** (for the Expo frontend)
2.  **Python 3.10+** (for the Django backend)
3.  **SWI-Prolog** (Must be installed and added to your system's `PATH` environment variable for `pyswip` to function).

---

## Setup & Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Mohamedahmed716/smart-study-advisor-lab3
cd smart-study-advisor-lab3
```

---

## 2. Backend Setup (Django & Prolog)

```bash
cd backend

# Create and activate a virtual environment
python -m venv venv

# On Windows
source venv/Scripts/activate

# On Mac/Linux
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Environment Variables (Backend)

Create a `.env` file in the `backend` directory and add your Groq API key:

```env
GROQ_API_KEY=gsk_your_api_key_here
```

### Start the Server

> Note: We bind to `0.0.0.0` to allow the mobile app to communicate with the local server.

```bash
python manage.py runserver 0.0.0.0:8000
```

---

## 3. Frontend Setup (React Native)

Open a new terminal window and navigate to the frontend directory:

```bash
cd frontend
npm install
```

### Environment Variables (Frontend)

Create a `.env` file in the `frontend` directory.

You must use your computer's actual IPv4 address (`ipconfig` on Windows or `ifconfig` on Mac/Linux) instead of `localhost`.

```env
EXPO_PUBLIC_API_URL=http://<YOUR_IPV4_ADDRESS>:8000/api
```

### Start the Mobile App

```bash
npx expo start
```

Scan the QR code with the Expo Go app on your physical device, or press `a` to open it in an Android Emulator.

---

## Testing the Application

### Non-AI Mode (Prolog)

Select:

- `"Beginner"`
- `"Security"`

The system will return no recommendations because Cybersecurity is considered a hard course, proving the logic engine works.

### AI Mode (Groq)

Select:

- `"Advanced"`
- `"Math"`
- `"AI"`

Toggle the engine to AI to receive generative insights explaining how these fields overlap.

---

## Team Members

- Ali Amr Abdullah Ahmed
- Omar Assem Ahmed
- Mohamed Ahmed Salama
- Nour Eldeen Mohamed
