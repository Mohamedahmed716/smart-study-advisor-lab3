def build_prompt(preferences: dict) -> str:
    level = preferences.get("level", "intermediate")
    interests_list = preferences.get("interests", [])
    completed_list = preferences.get("completed_courses", [])

    interests = ", ".join(interests_list) if interests_list else "None specified"
    completed = ", ".join(completed_list) if completed_list else "None"

    if not interests_list:
        strategy = "Since the student has no specific interests, prioritize fundamental and core courses appropriate for their level."
    else:
        strategy = f"Match courses heavily with these interests: {interests}."

    return f"""
You are a university course advisor. Recommend courses for this student.

Student profile:
- Level: {level}
- Interests: {interests}
- Completed Courses: {completed}

Recommendation Strategy:
{strategy}

Available courses (with difficulty):
Artificial Intelligence (Hard), Operating Systems (Medium), Algorithms (Hard),
Databases (Easy), Web Development (Easy), Data Structures (Medium),
Computer Networks (Medium), Software Engineering (Medium), Compilers (Hard),
Machine Learning (Hard), Cybersecurity (Hard), Digital Logic (Easy),
Discrete Math (Easy), Intro Programming (Easy), Computer Graphics (Hard)

Return ONLY a JSON array, no explanation, no markdown. Format:
[
  {{"course_name": "X", "difficulty": "Hard", "match_reason": "why this fits"}}
]
Recommend 2–4 courses. Only recommend courses appropriate for the student's level and not yet completed.
"""