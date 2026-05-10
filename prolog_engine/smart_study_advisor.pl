% ============================================================
%  Smart Study Advisor - Inference Engine
%  CSE-225: Programming Languages Paradigms - Lab 3
%  Logic Programmer Role
%  SWI-Prolog Compatible
% ============================================================

% ============================================================
%  SECTION 1: COURSE FACTS
%  course(CourseName, DifficultyLevel).
%  Difficulty levels: easy | medium | hard
% ============================================================

course(intro_programming,    easy).
course(discrete_math,        easy).
course(databases,            easy).
course(digital_logic,        easy).
course(algorithms,           hard).
course(operating_systems,    medium).
course(ai,                   medium).
course(machine_learning,     hard).
course(computer_networks,    medium).
course(software_engineering, medium).
course(computer_graphics,    hard).
course(cybersecurity,        hard).
course(data_structures,      medium).
course(compilers,            hard).
course(web_development,      easy).

% ============================================================
%  SECTION 2: COURSE TOPICS / INTEREST AREAS
%  course_topic(CourseName, Topic).
%  Topics: programming | math | systems | data | networks | security | design | web | ai
% ============================================================

course_topic(intro_programming,    programming).
course_topic(discrete_math,        math).
course_topic(databases,            data).
course_topic(digital_logic,        systems).
course_topic(algorithms,           math).
course_topic(algorithms,           programming).
course_topic(operating_systems,    systems).
course_topic(ai,                   ai).
course_topic(ai,                   programming).
course_topic(machine_learning,     ai).
course_topic(machine_learning,     math).
course_topic(computer_networks,    networks).
course_topic(computer_networks,    systems).
course_topic(software_engineering, programming).
course_topic(software_engineering, design).
course_topic(computer_graphics,    math).
course_topic(computer_graphics,    design).
course_topic(cybersecurity,        security).
course_topic(cybersecurity,        networks).
course_topic(data_structures,      programming).
course_topic(data_structures,      math).
course_topic(compilers,            programming).
course_topic(compilers,            systems).
course_topic(web_development,      web).
course_topic(web_development,      programming).

% ============================================================
%  SECTION 3: PREREQUISITE FACTS
%  prerequisite(Course, RequiredCourse).
%  Meaning: to take Course, student must have completed RequiredCourse.
% ============================================================

prerequisite(algorithms,           data_structures).
prerequisite(algorithms,           discrete_math).
prerequisite(data_structures,      intro_programming).
prerequisite(operating_systems,    digital_logic).
prerequisite(operating_systems,    data_structures).
prerequisite(ai,                   algorithms).
prerequisite(ai,                   discrete_math).
prerequisite(machine_learning,     ai).
prerequisite(machine_learning,     discrete_math).
prerequisite(computer_networks,    operating_systems).
prerequisite(computer_graphics,    algorithms).
prerequisite(computer_graphics,    discrete_math).
prerequisite(cybersecurity,        computer_networks).
prerequisite(software_engineering, data_structures).
prerequisite(software_engineering, intro_programming).
prerequisite(compilers,            algorithms).
prerequisite(compilers,            discrete_math).
prerequisite(databases,            intro_programming).
prerequisite(web_development,      intro_programming).

% ============================================================
%  SECTION 4: STUDENT PROFILES
%  completed(Student, Course).  - courses the student has already passed
%  prefers(Student, Topic).     - academic interests of the student
%  level(Student, Level).       - student level: beginner | intermediate | advanced
% ============================================================

% --- Student: omar ---
% Level: intermediate. Interested in AI and math. Has a solid programming base.
level(omar, intermediate).
prefers(omar, ai).
prefers(omar, math).
prefers(omar, programming).

completed(omar, intro_programming).
completed(omar, discrete_math).
completed(omar, data_structures).
completed(omar, algorithms).

% --- Student: sara ---
% Level: beginner. Interested in web and design. Just started.
level(sara, beginner).
prefers(sara, web).
prefers(sara, design).
prefers(sara, programming).

completed(sara, intro_programming).

% --- Student: ali ---
% Level: advanced. Interested in security and networks. Has most core courses done.
level(ali, advanced).
prefers(ali, security).
prefers(ali, networks).
prefers(ali, systems).

completed(ali, intro_programming).
completed(ali, discrete_math).
completed(ali, data_structures).
completed(ali, algorithms).
completed(ali, digital_logic).
completed(ali, operating_systems).
completed(ali, computer_networks).
completed(ali, databases).
completed(ali, software_engineering).

% ============================================================
%  SECTION 5: DIFFICULTY-LEVEL MAPPING
%  Maps student experience level to appropriate course difficulty.
% ============================================================

% A beginner should only take easy courses
suitable_difficulty(beginner, easy).

% An intermediate student can take easy or medium courses
suitable_difficulty(intermediate, easy).
suitable_difficulty(intermediate, medium).

% An advanced student can take any difficulty
suitable_difficulty(advanced, easy).
suitable_difficulty(advanced, medium).
suitable_difficulty(advanced, hard).

% ============================================================
%  SECTION 6: HELPER PREDICATES
% ============================================================

% --- prerequisites_met(Student, Course) ---
% True if the student has completed ALL prerequisites of Course.
% If a course has no prerequisites, it's always satisfied.
prerequisites_met(Student, Course) :-
    \+ prerequisite(Course, _).  % No prerequisites exist for this course

prerequisites_met(Student, Course) :-
    prerequisite(Course, _),     % At least one prerequisite exists
    \+ (prerequisite(Course, Prereq),
        \+ completed(Student, Prereq)).  % All prereqs must be completed

% --- not_completed(Student, Course) ---
% True if the student has NOT already completed the course.
not_completed(Student, Course) :-
    \+ completed(Student, Course).

% --- matches_interest(Student, Course) ---
% True if at least one of the course's topics matches a student's preferences.
matches_interest(Student, Course) :-
    course_topic(Course, Topic),
    prefers(Student, Topic).

% --- can_take(Student, Course) ---
% True if:
%   1. The course exists in the system
%   2. The student hasn't already completed it
%   3. All prerequisites are met
%   4. Course difficulty is appropriate for student's level
can_take(Student, Course) :-
    course(Course, Difficulty),
    not_completed(Student, Course),
    prerequisites_met(Student, Course),
    level(Student, Level),
    suitable_difficulty(Level, Difficulty).

% ============================================================
%  SECTION 7: MAIN RECOMMENDATION PREDICATE
%  recommend(Student, Course)
%  Recommends a course if the student can take it AND it matches their interests.
% ============================================================

% recommend/2 uses once/1 on matches_interest to avoid duplicate
% results when a course covers multiple matching topics.
recommend(Student, Course) :-
    can_take(Student, Course),
    once(matches_interest(Student, Course)).

% ============================================================
%  SECTION 8: UTILITY / REPORTING PREDICATES
% ============================================================

% --- all_recommendations(Student, Courses) ---
% Collects all recommended courses for a student into a sorted, deduplicated list.
all_recommendations(Student, Courses) :-
    findall(Course, recommend(Student, Course), Raw),
    sort(Raw, Courses).

% --- all_takeable(Student, Courses) ---
% Collects all courses a student is eligible for, sorted and deduplicated.
all_takeable(Student, Courses) :-
    findall(Course, can_take(Student, Course), Raw),
    sort(Raw, Courses).

% --- course_info(Course) ---
% Prints detailed info about a specific course.
course_info(Course) :-
    course(Course, Difficulty),
    findall(P, prerequisite(Course, P), Prereqs),
    findall(T, course_topic(Course, T), Topics),
    format("Course     : ~w~n", [Course]),
    format("Difficulty : ~w~n", [Difficulty]),
    format("Topics     : ~w~n", [Topics]),
    format("Prereqs    : ~w~n", [Prereqs]).

% --- student_info(Student) ---
% Prints a summary of a student's profile.
student_info(Student) :-
    level(Student, Level),
    findall(C, completed(Student, C), Completed),
    findall(P, prefers(Student, P), Prefs),
    format("Student    : ~w~n", [Student]),
    format("Level      : ~w~n", [Level]),
    format("Completed  : ~w~n", [Completed]),
    format("Interests  : ~w~n", [Prefs]).

% ============================================================
%  END OF KNOWLEDGE BASE
% ============================================================
