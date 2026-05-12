import json
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .gemeni_client import call_gemini
from .prompt_builder import build_prompt

class AIRecommendationView(APIView):
    def post(self, request):
        preferences = request.data.get("preferences", {})

        try:
            prompt = build_prompt(preferences)
            raw = call_gemini(prompt)
            
            # Robustly strip markdown fences and extra whitespace
            cleaned = raw.strip()
            if cleaned.startswith("```"):
                lines = cleaned.split('\n')
                if lines[0].startswith("```"):
                    lines = lines[1:]
                if lines and lines[-1].startswith("```"):
                    lines = lines[:-1]
                cleaned = '\n'.join(lines).strip()
                
            recommendations = json.loads(cleaned)
        except (json.JSONDecodeError, KeyError) as e:
            return Response(
                {"status": "error", "message": "AI returned malformed response"},
                status=status.HTTP_502_BAD_GATEWAY
            )
        except RuntimeError as e:
            return Response(
                {"status": "error", "message": str(e)},
                status=status.HTTP_503_SERVICE_UNAVAILABLE
            )

        return Response({
            "status": "success",
            "message": "Recommendations from Gemini AI",
            "recommendations": recommendations
        })