% ============================================================
    %  Smart Study Advisor - Inference Engine
    %  CSE-225: Programming Languages Paradigms - Lab 3
    %  Logic Programmer Role | SWI-Prolog Compatible
    % ============================================================

    :- discontiguous level/2.
    :- discontiguous prefers/2.
    :- discontiguous completed/2.

    % ============================================================
    %  SECTION 1: COURSE FACTS
    %  course(CourseName, DifficultyLevel).
    %  Difficulty: easy | medium | hard
    % ============================================================

        course(intro_programming,    easy).
            course(discrete_math,        easy).
            course(databases,            easy).
            course(digital_logic,        easy).
            course(web_development,      easy).
            course(data_structures,      medium).
            course(operating_systems,    medium).
            course(ai,                   medium).
            course(computer_networks,    medium).
            course(software_engineering, medium).
            course(algorithms,           hard).
            course(machine_learning,     hard).
            course(computer_graphics,    hard).
            course(cybersecurity,        hard).
            course(compilers,            hard).

            % ============================================================
        %  SECTION 2: COURSE TOPICS
    %  course_topic(CourseName, Topic).
    % ============================================================

    course_topic(intro_programming,    programming).
        course_topic(discrete_math,        math).
        course_topic(databases,            data).
        course_topic(digital_logic,        systems).
        course_topic(web_development,      web).
        course_topic(web_development,      programming).
        course_topic(data_structures,      programming).
        course_topic(data_structures,      math).
        course_topic(operating_systems,    systems).
        course_topic(ai,                   ai).
        course_topic(ai,                   programming).
        course_topic(computer_networks,    networks).
        course_topic(computer_networks,    systems).
        course_topic(software_engineering, programming).
        course_topic(software_engineering, design).
        course_topic(algorithms,           math).
        course_topic(algorithms,           programming).
        course_topic(machine_learning,     ai).
        course_topic(machine_learning,     math).
        course_topic(computer_graphics,    math).
        course_topic(computer_graphics,    design).
        course_topic(cybersecurity,        security).
        course_topic(cybersecurity,        networks).
        course_topic(compilers,            programming).
        course_topic(compilers,            systems).

        % ============================================================
    %  SECTION 3: PREREQUISITES
    %  prerequisite(Course, RequiredCourse).
    % ============================================================

    prerequisite(data_structures,      intro_programming).
        prerequisite(databases,            intro_programming).
        prerequisite(web_development,      intro_programming).
        prerequisite(operating_systems,    digital_logic).
        prerequisite(operating_systems,    data_structures).
        prerequisite(algorithms,           data_structures).
        prerequisite(algorithms,           discrete_math).
        prerequisite(software_engineering, intro_programming).
        prerequisite(software_engineering, data_structures).
        prerequisite(ai,                   algorithms).
        prerequisite(ai,                   discrete_math).
        prerequisite(computer_networks,    operating_systems).
        prerequisite(machine_learning,     ai).
        prerequisite(machine_learning,     discrete_math).
        prerequisite(computer_graphics,    algorithms).
        prerequisite(computer_graphics,    discrete_math).
        prerequisite(cybersecurity,        computer_networks).
        prerequisite(compilers,            algorithms).
        prerequisite(compilers,            discrete_math).

        % ============================================================
    %  SECTION 4: STUDENT PROFILES
    % ============================================================

        % --- Omar: intermediate, AI & math focus ---
    level(omar, intermediate).
    prefers(omar, ai).
    prefers(omar, math).
    prefers(omar, programming).
    completed(omar, intro_programming).
    completed(omar, discrete_math).
    completed(omar, data_structures).
    completed(omar, algorithms).

    % --- Sara: beginner, web & design focus ---
    level(sara, beginner).
    prefers(sara, web).
    prefers(sara, design).
    prefers(sara, programming).
    completed(sara, intro_programming).

    % --- Ali: advanced, security & networks focus ---
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
    % ============================================================

        suitable_difficulty(beginner,     easy).
            suitable_difficulty(intermediate, easy).
            suitable_difficulty(intermediate, medium).
            suitable_difficulty(advanced,     easy).
            suitable_difficulty(advanced,     medium).
            suitable_difficulty(advanced,     hard).

            % ============================================================
        %  SECTION 6: HELPER PREDICATES
    % ============================================================

        not_completed(Student, Course) :-
    \+ completed(Student, Course).

    prerequisites_met(_Student, Course) :-
    \+ prerequisite(Course, _).
    prerequisites_met(Student, Course) :-
    prerequisite(Course, _),
    \+ (prerequisite(Course, Prereq),
        \+ completed(Student, Prereq)).

        matches_interest(Student, Course) :-
    course_topic(Course, Topic),
    prefers(Student, Topic).

        can_take(Student, Course) :-
    course(Course, Difficulty),
    not_completed(Student, Course),
    prerequisites_met(Student, Course),
    level(Student, Level),
    suitable_difficulty(Level, Difficulty).

        % ============================================================
        %  SECTION 7: MAIN RECOMMENDATION PREDICATE
    % ============================================================

        recommend(Student, Course) :-
    can_take(Student, Course),
    once(matches_interest(Student, Course)).

        % ============================================================
        %  SECTION 8: UTILITY PREDICATES
    % ============================================================

        all_recommendations(Student, Courses) :-
    findall(C, recommend(Student, C), Raw),
    sort(Raw, Courses).

        all_takeable(Student, Courses) :-
    findall(C, can_take(Student, C), Raw),
    sort(Raw, Courses).

        course_info(Course) :-
    course(Course, Difficulty),
    findall(P, prerequisite(Course, P), Prereqs),
    findall(T, course_topic(Course, T), Topics),
format("Course     : ~w~n", [Course]),
    format("Difficulty : ~w~n", [Difficulty]),
    format("Topics     : ~w~n", [Topics]),
    format("Prereqs    : ~w~n", [Prereqs]).

student_info(Student) :-
    level(Student, Level),
    findall(C, completed(Student, C), Completed),
    findall(P, prefers(Student, P), Prefs),
    format("Student    : ~w~n", [Student]),
    format("Level      : ~w~n", [Level]),
    format("Completed  : ~w~n", [Completed]),
    format("Interests  : ~w~n", [Prefs]).