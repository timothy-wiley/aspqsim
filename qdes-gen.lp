%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% QDE Integrity constraints
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QDEs that are generated into other QDEs but do not depend on time

#program base.

% scale * cosine(X, Y) - X angle, Y result
% cosine is encoded in the form of M+/M- relations, 
%   some massarging is required to get the preconds and corresponding values correct
% x_test :- rule(Name, Precond, cosine(QVar1, QVar2)).
precond(cosine(Name,N), and, Precond) :-
    rule(Name, Precond, cosine(QVar1, QVar2)),
    N = 1..3.
precond(cosine(Name,N), and, cosine_precond(Name,N)) :-
    rule(Name, Precond, cosine(QVar1, QVar2)),
    N = 1..3.
precond(cosine_precond(Name,1), bound, QVar1, i, n3pi2, i, npi) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).
precond(cosine_precond(Name,2), bound, QVar1, i, npi, i, zero) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).
precond(cosine_precond(Name,3), bound, QVar1, i, zero, i, pi) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).
rule(cosine(Name,1), cosine(Name,1), mminus(QVar1, QVar2)) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).
rule(cosine(Name,2), cosine(Name,2), mplus(QVar1, QVar2)) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).
rule(cosine(Name,3), cosine(Name,3), mminus(QVar1, QVar2)) :-
    rule(Name, Precond, cosine(QVar1, QVar2)).

correspond(cosine(Name, 1), land(n3pi2), land(zero)) :- rule(Name, Precond, cosine(QVar1, QVar2)).
correspond(cosine(Name, 1), land(npi), land(Neg)) :- rule(Name, Precond, cosine(QVar1, QVar2)),
    first_landmark(QVar2, Neg).
correspond(cosine(Name, 2), land(npi), land(Neg)) :- rule(Name, Precond, cosine(QVar1, QVar2)),
    first_landmark(QVar2, Neg).
correspond(cosine(Name, 2), land(npi2), land(zero)) :- rule(Name, Precond, cosine(QVar1, QVar2)).
correspond(cosine(Name, 2), land(zero), land(Pos)) :- rule(Name, Precond, cosine(QVar1, QVar2)),
    last_landmark(QVar2, Pos).
correspond(cosine(Name, 3), land(zero), land(Pos)) :- rule(Name, Precond, cosine(QVar1, QVar2)),
    last_landmark(QVar2, Pos).
correspond(cosine(Name, 3), land(pi2), land(zero)) :- rule(Name, Precond, cosine(QVar1, QVar2)).
correspond(cosine(Name, 3), land(pi), land(Neg)) :- rule(Name, Precond, cosine(QVar1, QVar2)),
    first_landmark(QVar2, Neg).


% -1 * scale * sine(X, Y) - X angle, Y result
% sine_invert is encoded in the form of M+/M- relations, with a scaling of -1 encoded
%Comment: a sine_invert rule is not replaced by other rules but simply not handled
% so we just add 4 other rules that combine the precondition with 4 different, exclusive,
% preconditions, only one of the rules will then fire
% the other 3 rules are deactivated because of their precondition
% the original rule is maybe activated, but does not do anything
precond(sine_invert(Name,N), and, Precond) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)),
    N = 1..4.
precond(sine_invert(Name,N), and, sine_invert_precond(Name,N)) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)),
    N = 1..4.
precond(sine_invert_precond(Name,1), bound, QVar1, i, n3pi2, i, npi) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
precond(sine_invert_precond(Name,2), bound, QVar1, i, npi, i, npi2) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
precond(sine_invert_precond(Name,3), bound, QVar1, i, npi2, i, pi2) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
precond(sine_invert_precond(Name,4), bound, QVar1, i, pi2, i, pi) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
rule(sine_invert(Name,1), sine_invert(Name,1), mplus(QVar1, QVar2)) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
rule(sine_invert(Name,2), sine_invert(Name,2), mplus(QVar1, QVar2)) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
rule(sine_invert(Name,3), sine_invert(Name,3), mminus(QVar1, QVar2)) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
rule(sine_invert(Name,4), sine_invert(Name,4), mplus(QVar1, QVar2)) :-
    rule(Name, Precond, sine_invert(QVar1, QVar2)).

correspond(sine_invert(Name, 1), land(n3pi2), land(Neg)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    first_landmark(QVar2, Neg).
correspond(sine_invert(Name, 1), land(npi), land(zero)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
correspond(sine_invert(Name, 2), land(npi), land(zero)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
correspond(sine_invert(Name, 2), land(npi2), land(Pos)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    last_landmark(QVar2, Pos).
correspond(sine_invert(Name, 3), land(npi2), land(Pos)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    last_landmark(QVar2, Pos).
correspond(sine_invert(Name, 3), land(zero), land(zero)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)).
correspond(sine_invert(Name, 3), land(pi2), land(Neg)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    first_landmark(QVar2, Neg).
correspond(sine_invert(Name, 4), land(pi2), land(Neg)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    first_landmark(QVar2, Neg).
correspond(sine_invert(Name, 4), land(pi), land(zero)) :- 
    rule(Name, Precond, sine_invert(QVar1, QVar2)), 
    first_landmark(QVar2, Neg).

