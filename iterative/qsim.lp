%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% QSIM state transition rules
% Preconditions for QDEs
% Initial/Goal states
%
% VERSION FOR ITERATIVE SOLVING WITH DYNAMIC t.
% Requires T = t type clauses in each cumulative(t) rule
%

% Configuration variables
#const istop  = "SAT".
#const imin   = 1.
#const imax   = 50.
#const iquery = 1.

#program base.

% Initial state - doesn't change
holds(p(0),V,Q,D) :- init(V,Q,D).
1{ holds(p(0),V,Q,D) : qmag(V,Q), qdir(D) } 1 :- qvar(V).

% Enable/disable quantiative constraints
%mode_quant.

#program cumulative(t).

% Version of time that gives a timestep for a t
% This version of time is required for iterative mode
time(p(t)).
time(i(T1,t)) :- time(p(T1)), T1 = t - 1.
time(t, p(t))    :- time(p(t)).
time(t, i(T1,t)) :- time(i(T1,t)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% State transition rules
% Use the generate-and-test paradigm, by generating all possible states and ruling out states by integrity constraints
% Kuipers, B. J. (1986). Qualitative Simulation. Artificial Intelligence, 29(3), 289–338

% holds(Time, QVar, Mag, Dir)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i'm sure that this can be optimized splitting Dir vom Mag,
% but i would need the general rules to get an overview

%%%
% Point to Interval
%   time(T1) is required to ensure stopping at max time
1 { holds(i(T, T1), QVar, interval(L1, L2), QDir) : qdir(QDir) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, interval(L1, L2), std).  % P8/I9
1 { holds(i(T, T1), QVar, interval(L1, L2), inc) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, interval(L1, L2), inc).  % P5
1 { holds(i(T, T1), QVar, interval(L1, L2), dec) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, interval(L1, L2), dec).  % P7
1 { holds(i(T, T1), QVar, land(L1), std);
    holds(i(T, T1), QVar, interval(L1, L2), inc) : qmag(QVar, interval(L1, L2));
    holds(i(T, T1), QVar, interval(L0, L1), dec) : qmag(QVar, interval(L0, L1)) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, land(L1), std).  % P1, P2, P3
1 { holds(i(T, T1), QVar, interval(L1, L2), inc) : qmag(QVar, interval(L1, L2)) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, land(L1), inc).  % P4
1 { holds(i(T, T1), QVar, interval(L0, L1), dec) : qmag(QVar, interval(L0, L1)) } 1
    :- T1 = t, time(i(T,T1)), not discrete(QVar), holds(p(T), QVar, land(L1), dec).  % P5

% Interval to Point
1 { holds(p(T1), QVar, interval(L1, L2), QDir) : time(p(T1)), qdir(QDir) } 1
    :- T1 = t, not discrete(QVar), holds(i(T, T1), QVar, interval(L1, L2), std).  % I8/I9
1 { holds(p(T1), QVar, interval(L1, L2), inc);
    holds(p(T1), QVar, interval(L1, L2), std);
    holds(p(T1), QVar, land(L2), inc) : qmag(QVar, land(L2));
    holds(p(T1), QVar, land(L2), std) : qmag(QVar, land(L2)) } 1
    :- T1 = t, not discrete(QVar), holds(i(T, T1), QVar, interval(L1, L2), inc).  % I4, I8, I3, I2
1 { holds(p(T1), QVar, interval(L1, L2), dec);
    holds(p(T1), QVar, interval(L1, L2), std);
    holds(p(T1), QVar, land(L1), dec) : qmag(QVar, land(L1));
    holds(p(T1), QVar, land(L1), std) : qmag(QVar, land(L1)) } 1
    :- T1 = t, not discrete(QVar), holds(i(T, T1), QVar, interval(L1, L2), dec).  % I7, I9, I6, I5
1 { holds(p(T1), QVar, land(L1), std) } 1
    :- T1 = t, not discrete(QVar), holds(i(T, T1), QVar, land(L1), std).  % I8/I9

% Discrete versions of state transitions
1 { holds(i(T, T1), QVar, land(L1), std);
    holds(i(T, T1), QVar, land(L0), std) : adjacent_landmark(QVar, L0, L1), not invalid_landmark(L0);
    holds(i(T, T1), QVar, land(L2), std) : adjacent_landmark(QVar, L1, L2), not invalid_landmark(L2) } 1
    :- T1 = t, time(i(T,T1)), discrete(QVar), holds(p(T), QVar, land(L1), std).
1 { holds(p(T1), QVar, land(L1), std);
    holds(p(T1), QVar, land(L0), std) : adjacent_landmark(QVar, L0, L1), not invalid_landmark(L0);
    holds(p(T1), QVar, land(L2), std) : adjacent_landmark(QVar, L1, L2), not invalid_landmark(L2) } 1
    :- T1 = t,                discrete(QVar), holds(i(T,T1), QVar, land(L1), std).


% Holds preconds
precond(X,OP) :- precond(X,OP,_).
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, holds_precond(T,Y) : precond(X,and,Y); precond(X,and), time(T).
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, holds_precond(T,Y),  precond(X,or,Y).
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, not holds_precond(T,Y),  precond(X,neg,Y), time(T).

% Split holds mag/dir to speed up solving
holds_mag(T, QVar, Mag) :- 1 {T = p(t); T = i(T1,t) } 1, holds(T, QVar, Mag, _).
holds_dir(T, QVar, Dir) :- 1 {T = p(t); T = i(T1,t) } 1, holds(T, QVar, _, Dir).

% dir constraint for discrete vars
:- 1 {T = p(t); T = i(T1, t) } 1, discrete(QVar), holds_dir(T, QVar, inc).
:- 1 {T = p(t); T = i(T1, t) } 1, discrete(QVar), holds_dir(T, QVar, dec).

% Bound helper methods
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, 
                      precond(X, bound, Var, Lower, Min, Upper, Max), time(T),
                      holds_mag(T,Var,Mag),
                      relative_qmag(Var, Mag, land(Min), Sign1),
                      relative_qmag(Var, Mag, land(Max), Sign2),
                      precond_bound_lower(Lower, Sign1),
                      precond_bound_upper(Upper, Sign2).
		 
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, 
                      precond(X, equal, Var, Mag), time(T),
                      holds_mag(T,Var,Mag).


% True/false precondition
% precond(true,neg,false).
holds_precond(T,X) :- 1 {T = p(t); T = i(T1,t) } 1, precond(X, true), time(T).


% Specify goal
#program volatile(t).
#external query(t).
%:- not time(p(t)), query(t).
:- T = p(t), time(T), not holds(T,V,Q,D), goal(V,Q,D), query(t).

