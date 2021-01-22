%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Produce collection of actions at each time step
% If not planning action sequences, this file can be dropped from use
%

% Time steps and intervals
% timemax(8).
% timemax(t).
% timestep(0..T) :- timemax(T).
% time(p(T)) :- timestep(T).
% time(i(T1,T2)) :- timestep(T1), timestep(T2), T2 = T1 + 1.

% action(Time, ControlVar, Mag, Dir)
action(p(T), CQVar, Mag2, Dir2) :- control(CQVar),
    holds(p(T), CQVar, Mag1, Dir1), holds(i(T,T+1), CQVar, Mag2, Dir2),
    holds(i(T-1,T), CQVar, Mag0, Dir0),
    1 { Mag0 != Mag2; Dir0 != Dir2 } 2,
    1 { Mag1 != Mag2; Dir1 != Dir2 } 2.
action(p(T), CQVar, Mag2, Dir2) :- control(CQVar),
    holds(p(T), CQVar, Mag1, Dir1), holds(i(T,T+1), CQVar, Mag2, Dir2),
    not time(i(T-1,T)),
    1 { Mag1 != Mag2; Dir1 != Dir2 } 2.

action(i(T,T1), CQVar, Mag2, Dir2) :- control(CQVar),
    holds(i(T,T1), CQVar, Mag1, Dir1), holds(p(T1), CQVar, Mag2, Dir2),
    holds(i(T1,T1+1), CQVar, Mag3, Dir3),
    1 { Mag1 != Mag2; Dir1 != Dir2 } 2,
    1 { Mag1 != Mag3; Dir1 != Dir3 } 2.
action(i(T,T1), CQVar, Mag2, Dir2) :- control(CQVar),
    holds(i(T,T1), CQVar, Mag1, Dir1), holds(p(T1), CQVar, Mag2, Dir2),
    not time(i(T1,T1+1)),
    1 { Mag1 != Mag2; Dir1 != Dir2 } 2.


