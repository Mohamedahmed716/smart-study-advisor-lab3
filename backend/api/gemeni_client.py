import os, requests
from dotenv import load_dotenv
load_dotenv()

GEMINI_URL ="https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"

def call_gemini(prompt: str) -> str:
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        raise ValueError("GEMINI_API_KEY not set")

    try:
        resp = requests.post(
            GEMINI_URL,
            params={"key": api_key},
            json={"contents": [{"parts": [{"text": prompt}]}]},
            timeout=10
        )
        resp.raise_for_status()
        return resp.json()["candidates"][0]["content"]["parts"][0]["text"]
    except requests.Timeout:
        raise RuntimeError("Gemini API timed out")
    except requests.RequestException as e:
        raise RuntimeError(f"Gemini API error: {e}")