from django.urls import path
from .views import CourseRecommendationView

from .ai_views import AIRecommendationView

urlpatterns = [
    path('recommend/', CourseRecommendationView.as_view(), name='recommend'),
    path('ai-recommend/', AIRecommendationView.as_view(), name='ai_recommend'),
]