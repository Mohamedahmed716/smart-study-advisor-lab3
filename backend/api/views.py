from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

# PARADIGM: Object-Oriented Programming (System Design)
# Inheriting from APIView encapsulates HTTP methods inside a class structure.
        # PARADIGM: Imperative (Execution Flow)
        # Step 1: Extract the payload sent by the mobile app
        # TODO: Later, we will pass these preferences to the Prolog Engine here.
        # For now, we return dummy data so the Mobile Developer can build the UI.
        # Step 2: Return the JSON response
class CourseRecommendationView(APIView):
    
    def post(self, request):

        student_prefs = request.data.get('preferences', {})
        
        mock_recommendations = [
            {"course_name": "Artificial Intelligence", "difficulty": "Hard", "match_reason": "Matches interest in logic"},
            {"course_name": "Operating Systems", "difficulty": "Medium", "match_reason": "Prerequisites cleared"},
        ]


        return Response({
            "status": "success",
            "message": "Prolog engine bypassed for now. Showing mock data.",
            "recommendations": mock_recommendations
        }, status=status.HTTP_200_OK)
