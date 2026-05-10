% ============================================================
%  Smart Study Advisor - Test Queries
%  Run after loading: ?- [smart_study_advisor].
%  Then copy-paste any query below into SWI-Prolog REPL.
% ============================================================

% ============================================================
%  GROUP 1: BASIC COURSE FACTS
% ============================================================

% Q1: List all courses with their difficulty
% ?- course(X, D).
% Expected output (all 15):
%   X = intro_programming, D = easy ;
%   X = discrete_math,     D = easy ;
%   X = databases,         D = easy ;
%   X = digital_logic,     D = easy ;
%   X = algorithms,        D = hard ;
%   X = operating_systems, D = medium ;
%   X = ai,                D = medium ;
%   X = machine_learning,  D = hard ;
%   X = computer_networks, D = medium ;
%   X = software_engineering, D = medium ;
%   X = computer_graphics, D = hard ;
%   X = cybersecurity,     D = hard ;
%   X = data_structures,   D = medium ;
%   X = compilers,         D = hard ;
%   X = web_development,   D = easy.

% Q2: List all hard courses
% ?- course(X, hard).
% Expected:
%   X = algorithms ;
%   X = machine_learning ;
%   X = computer_graphics ;
%   X = cybersecurity ;
%   X = compilers.

% Q3: What are the prerequisites for ai?
% ?- prerequisite(ai, X).
% Expected:
%   X = algorithms ;
%   X = discrete_math.

% ============================================================
%  GROUP 2: STUDENT PROFILES
% ============================================================

% Q4: What has omar completed?
% ?- completed(omar, X).
% Expected:
%   X = intro_programming ;
%   X = discrete_math ;
%   X = data_structures ;
%   X = algorithms.

% Q5: What are sara's interests?
% ?- prefers(sara, X).
% Expected:
%   X = web ;
%   X = design ;
%   X = programming.

% Q6: What level is ali?
% ?- level(ali, X).
% Expected:
%   X = advanced.

% ============================================================
%  GROUP 3: can_take/2 QUERIES
% ============================================================

% Q7: Can omar take ai?
% ?- can_take(omar, ai).
% Expected: true.
% Reasoning: omar completed algorithms + discrete_math (prereqs met),
%            level=intermediate, ai=medium => suitable.

% Q8: Can sara take ai?
% ?- can_take(sara, ai).
% Expected: false.
% Reasoning: Sara hasn't completed algorithms or discrete_math.

% Q9: Can sara take web_development?
% ?- can_take(sara, web_development).
% Expected: true.
% Reasoning: Sara completed intro_programming (only prereq),
%            level=beginner, web_development=easy => suitable.

% Q10: Can sara take databases?
% ?- can_take(sara, databases).
% Expected: true.
% Reasoning: Sara completed intro_programming, databases=easy.

% Q11: Can ali take cybersecurity?
% ?- can_take(ali, cybersecurity).
% Expected: true.
% Reasoning: Ali completed computer_networks (the prereq),
%            level=advanced, cybersecurity=hard => suitable.

% Q12: What courses can omar take? (all eligible courses)
% ?- can_take(omar, X).
% Expected (courses omar can take but hasn't completed):
%   X = databases ;
%   X = digital_logic ;
%   X = operating_systems ;
%   X = ai ;
%   X = computer_networks ;  % (needs os, which omar hasn't done)
%   ... (varies based on prerequisite chain)
% Note: exact set depends on what's been completed and prereqs.

% ============================================================
%  GROUP 4: matches_interest/2 QUERIES
% ============================================================

% Q13: Does cybersecurity match ali's interests?
% ?- matches_interest(ali, cybersecurity).
% Expected: true.
% Reasoning: cybersecurity has topics [security, networks], ali prefers both.

% Q14: Does machine_learning match omar's interests?
% ?- matches_interest(omar, machine_learning).
% Expected: true.
% Reasoning: machine_learning has topics [ai, math], omar prefers both.

% Q15: Does web_development match ali's interests?
% ?- matches_interest(ali, web_development).
% Expected: false.
% Reasoning: web_development topics are [web, programming]; ali prefers [security, networks, systems].

% Q16: Which courses match sara's interests?
% ?- matches_interest(sara, X).
% Expected (courses with web/design/programming topics):
%   X = intro_programming ;
%   X = software_engineering ;
%   X = computer_graphics ;
%   X = data_structures ;
%   X = compilers ;
%   X = web_development.

% ============================================================
%  GROUP 5: recommend/2 QUERIES  (main predicate)
% ============================================================

% Q17: What does the system recommend for omar?
% ?- recommend(omar, X).
% Expected:
%   X = ai ;
%   X = operating_systems ; (if digital_logic done... actually omar hasn't done it)
%   X = software_engineering ;
%   false.
% (Exact set: courses omar can take AND match his interests in ai/math/programming)

% Q18: What does the system recommend for sara?
% ?- recommend(sara, X).
% Expected:
%   X = web_development ;
%   false.
% Reasoning: sara can take web_development (prereq: intro_programming done, easy level),
%            and it matches her interests (web, programming).

% Q19: What does the system recommend for ali?
% ?- recommend(ali, X).
% Expected:
%   X = cybersecurity ;
%   X = machine_learning ;
%   false.
% Reasoning: ali is advanced, has most prereqs done, interests are security/networks/systems.

% Q20: Collect ALL recommendations for omar into a list
% ?- all_recommendations(omar, Courses).
% Expected:
%   Courses = [ai, software_engineering, ...].

% Q21: Collect ALL recommendations for sara
% ?- all_recommendations(sara, Courses).
% Expected:
%   Courses = [web_development].

% Q22: Collect ALL recommendations for ali
% ?- all_recommendations(ali, Courses).
% Expected:
%   Courses = [cybersecurity, machine_learning, ...].

% ============================================================
%  GROUP 6: UTILITY QUERIES
% ============================================================

% Q23: Print info about a specific course
% ?- course_info(ai).
% Expected output:
%   Course     : ai
%   Difficulty : medium
%   Topics     : [ai,programming]
%   Prereqs    : [algorithms,discrete_math]

% Q24: Print a student's profile summary
% ?- student_info(omar).
% Expected output:
%   Student    : omar
%   Level      : intermediate
%   Completed  : [intro_programming,discrete_math,data_structures,algorithms]
%   Interests  : [ai,math,programming]

% Q25: What topics does machine_learning cover?
% ?- course_topic(machine_learning, T).
% Expected:
%   T = ai ;
%   T = math.

% Q26: Which courses cover the 'security' topic?
% ?- course_topic(X, security).
% Expected:
%   X = cybersecurity.

% Q27: Which courses cover the 'math' topic?
% ?- course_topic(X, math).
% Expected:
%   X = discrete_math ;
%   X = algorithms ;
%   X = machine_learning ;
%   X = computer_graphics ;
%   X = data_structures.

% Q28: Are there any difficulty levels omar is NOT suitable for?
% ?- level(omar, L), \+ suitable_difficulty(L, hard).
% Expected: true. (intermediate cannot take hard courses)

% Q29: Can anyone take machine_learning right now?
% ?- recommend(S, machine_learning).
% Expected: false (or ali if he meets prereqs).
% Reasoning: machine_learning requires ai, which requires algorithms + discrete_math.

% Q30: All courses ali can take (eligible, regardless of interest)
% ?- all_takeable(ali, Courses).
% Expected: [cybersecurity, machine_learning, computer_graphics, compilers, ...]
