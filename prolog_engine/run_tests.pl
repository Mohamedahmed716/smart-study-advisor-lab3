% ============================================================
%  run_tests.pl — Smart Study Advisor Test Suite
%  CSE-225 Lab 3 | SWI-Prolog
%
%  Usage (from the project folder):
%    swipl -g "run_tests, halt" run_tests.pl
% ============================================================

:- consult('smart_study_advisor.pl').

% ---- test harness state ----
:- dynamic t_total/1, t_pass/1, t_fail/1.
t_total(0). t_pass(0). t_fail(0).

bump(F) :-
    functor(T, F, 1), call(T), arg(1, T, N),
    N1 is N + 1, functor(T1, F, 1), arg(1, T1, N1),
    retract(T), assert(T1).

pass(Label) :- bump(t_total), bump(t_pass),
    format("  PASS  ~w~n", [Label]).

fail(Label, Got, Expected) :- bump(t_total), bump(t_fail),
    format("  FAIL  ~w~n         expected : ~w~n         got      : ~w~n",
           [Label, Expected, Got]).

check_true(Label, Goal) :-
    ( call(Goal) -> pass(Label) ; fail(Label, false, true) ).

check_false(Label, Goal) :-
    ( \+ call(Goal) -> pass(Label) ; fail(Label, true, false) ).

check_eq(Label, Result, Expected) :-
    ( Result == Expected -> pass(Label) ; fail(Label, Result, Expected) ).

section(Title) :- format("~n[ ~w ]~n", [Title]).

% ============================================================
run_tests :-
    format("~n============================================================~n"),
    format(" Smart Study Advisor - Test Suite~n"),
    format("============================================================~n"),

    % ----------------------------------------------------------
    section('1. Course Facts'),
    check_true( 'course(ai, medium) exists',          course(ai, medium) ),
    check_true( 'course(algorithms, hard) exists',    course(algorithms, hard) ),
    check_true( 'course(web_development, easy)',      course(web_development, easy) ),
    check_false('course(fake_course, _) not in KB',   course(fake_course, _) ),
    findall(X, course(X,_), CL), length(CL, CN),
    check_eq(   '15 courses in knowledge base',       CN, 15),

    % ----------------------------------------------------------
    section('2. Prerequisites'),
    check_true( 'prerequisite(ai, algorithms)',           prerequisite(ai, algorithms) ),
    check_true( 'prerequisite(ai, discrete_math)',        prerequisite(ai, discrete_math) ),
    check_true( 'prerequisite(cybersecurity, computer_networks)',
                                                          prerequisite(cybersecurity, computer_networks) ),
    check_false('no prerequisite for intro_programming',  prerequisite(intro_programming, _) ),
    check_false('no prerequisite for discrete_math',      prerequisite(discrete_math, _) ),

    % ----------------------------------------------------------
    section('3. Student Profiles'),
    check_true( 'omar is intermediate',          level(omar, intermediate) ),
    check_true( 'sara is beginner',              level(sara, beginner) ),
    check_true( 'ali is advanced',               level(ali, advanced) ),
    check_true( 'omar completed algorithms',     completed(omar, algorithms) ),
    check_true( 'sara completed intro_programming', completed(sara, intro_programming) ),
    check_false('sara did NOT complete ai',      completed(sara, ai) ),
    check_true( 'omar prefers ai',               prefers(omar, ai) ),
    check_true( 'ali prefers security',          prefers(ali, security) ),
    check_false('ali does NOT prefer web',       prefers(ali, web) ),

    % ----------------------------------------------------------
    section('4. not_completed/2'),
    check_true( 'not_completed(omar, ai)',           not_completed(omar, ai) ),
    check_false('not not_completed(omar, algorithms)',not_completed(omar, algorithms) ),
    check_true( 'not_completed(sara, cybersecurity)',not_completed(sara, cybersecurity) ),

    % ----------------------------------------------------------
    section('5. prerequisites_met/2'),
    check_true( 'omar meets prereqs for ai',               prerequisites_met(omar, ai) ),
    check_true( 'sara meets prereqs for web_development',  prerequisites_met(sara, web_development) ),
    check_true( 'ali meets prereqs for cybersecurity',     prerequisites_met(ali, cybersecurity) ),
    check_true( 'no prereqs for discrete_math -> always met', prerequisites_met(sara, discrete_math) ),
    check_false('sara does NOT meet prereqs for ai',       prerequisites_met(sara, ai) ),
    check_false('omar does NOT meet prereqs for machine_learning',
                                                           prerequisites_met(omar, machine_learning) ),

    % ----------------------------------------------------------
    section('6. matches_interest/2'),
    check_true( 'matches_interest(omar, ai)',              matches_interest(omar, ai) ),
    check_true( 'matches_interest(ali, cybersecurity)',    matches_interest(ali, cybersecurity) ),
    check_true( 'matches_interest(sara, web_development)', matches_interest(sara, web_development) ),
    check_false('matches_interest(ali, web_development)',  matches_interest(ali, web_development) ),
    check_false('matches_interest(sara, operating_systems)', matches_interest(sara, operating_systems) ),

    % ----------------------------------------------------------
    section('7. can_take/2'),
    check_true( 'can_take(omar, ai)',              can_take(omar, ai) ),
    check_true( 'can_take(sara, web_development)', can_take(sara, web_development) ),
    check_true( 'can_take(ali, cybersecurity)',    can_take(ali, cybersecurity) ),
    check_false('can_take(sara, ai)        [prereqs missing]',   can_take(sara, ai) ),
    check_false('can_take(sara, algorithms)[difficulty too high]',can_take(sara, algorithms) ),
    check_false('can_take(omar, algorithms)[already completed]',  can_take(omar, algorithms) ),
    check_false('can_take(omar, machine_learning)[needs ai first]',can_take(omar, machine_learning) ),

    % ----------------------------------------------------------
    section('8. recommend/2'),
    check_true( 'recommend(omar, ai)',              recommend(omar, ai) ),
    check_true( 'recommend(sara, web_development)', recommend(sara, web_development) ),
    check_true( 'recommend(ali, cybersecurity)',    recommend(ali, cybersecurity) ),
    check_false('recommend(sara, ai)',              recommend(sara, ai) ),
    check_false('recommend(ali, web_development)',  recommend(ali, web_development) ),
    check_false('recommend(omar, machine_learning)',recommend(omar, machine_learning) ),

    % ----------------------------------------------------------
    section('9. all_recommendations/2'),
    all_recommendations(omar, OR),
    check_eq('all_recommendations(omar)', OR, [ai, software_engineering, web_development]),

    all_recommendations(sara, SR),
    check_eq('all_recommendations(sara)', SR, [web_development]),

    all_recommendations(ali, AR),
    check_eq('all_recommendations(ali)',  AR, [compilers, cybersecurity]),

    % ----------------------------------------------------------
    section('10. all_takeable/2'),
    all_takeable(sara, SC),
    check_false('all_takeable(sara) is non-empty',    SC == [] ),
    all_takeable(ali, AC),
    check_true( 'all_takeable(ali) includes cybersecurity', member(cybersecurity, AC) ),
    all_takeable(omar, OC),
    check_true( 'all_takeable(omar) includes ai',           member(ai, OC) ),
    check_false('all_takeable(omar) excludes machine_learning', member(machine_learning, OC) ),

    % ----------------------------------------------------------
    format("~n============================================================~n"),
    t_total(Total), t_pass(Passed), t_fail(Failed),
    format(" Results: ~w / ~w passed", [Passed, Total]),
    ( Failed =:= 0
    -> format("  -- ALL TESTS PASSED~n")
    ;  format("  -- ~w FAILED~n", [Failed])
    ),
    format("============================================================~n~n").

