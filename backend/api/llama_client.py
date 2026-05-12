import os, requests
from dotenv import load_dotenv

load_dotenv()

def call_llama(prompt: str) -> str:
    api_key = os.getenv("GROQ_API_KEY")
    if not api_key:
        raise ValueError("GROQ_API_KEY not set")

    url = "https://api.groq.com/openai/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    payload = {
        "model": "llama-3.3-70b-versatile", # Updated to current supported model
        "messages": [{"role": "user", "content": prompt}],
        "temperature": 0.7
    }

    try:
        resp = requests.post(url, headers=headers, json=payload, timeout=10)
        resp.raise_for_status()
        return resp.json()["choices"][0]["message"]["content"]
        
    except requests.exceptions.HTTPError as e:
        # This captures the EXACT reason the API rejected the request
        error_details = e.response.text
        print(f"\n--- API REJECTION DETAILS ---\n{error_details}\n-----------------------------\n")
        raise RuntimeError(f"API rejected request. Check Django terminal for details.")
        
    except requests.RequestException as e:
        raise RuntimeError(f"Network error: {e}")