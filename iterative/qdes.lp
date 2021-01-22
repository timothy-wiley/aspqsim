%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% QDE Integrity constraints
%
% VERSION FOR ITERATIVE SOLVING WITH DYNAMIC t.
% Requires T = t type clauses in each cumulative(t) rule
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QDE Constraints

#program cumulative(t).

holds_constraint(T,N,C) :- 1 {T = p(t); T = i(T1,t) } 1, rule(N,P,C), holds_precond(T,P).
holds_constraint(T,C)   :- 1 {T = p(t); T = i(T1,t) } 1, holds_constraint(T,N,C).

% const(QVar, Mag)
:- 1 {T = p(t); T = i(T1,t) } 1, holds_constraint(T, const(QVar, Mag)), not holds(T, QVar, Mag, std).

% const_any(QVar, Mag)
:- 1 {T = p(t); T = i(T1,t) } 1, holds_constraint(T, const_any(QVar)), holds_dir(T, QVar, Dir), Dir != std.

% sum(X, Y, Z): Z = X + Y
% correspond_sum(Name, X, Y, Z)
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, sum(QVar1, QVar2, QVar3)), holds_dir(T, QVar1, Dir1), holds_dir(T, QVar2, Dir2), holds_dir(T, QVar3, Dir3),
       not qdirsum(Dir1, Dir2, Dir3).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, sum(QVar1, QVar2, QVar3)),
       holds(T, QVar1, QMag1, Dir1), holds(T, QVar2, QMag2, Dir2), holds(T, QVar3, QMag3, Dir3),
       qdirsum(Dir1, Dir2, Dir3),
       correspond_sum(Name, Corr1, Corr2, Corr3),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       relative_qmag(QVar3, QMag3, Corr3, Sign3),
       not qsum(Sign1, Sign2, Sign3).

% M+(X,Y)
% correspond(Name, X, Y)
:- 1 {T = p(t); T = i(T1,t) } 1, 
   holds_constraint(T, mplus(QVar1, QVar2)), holds_dir(T, QVar1, Dir1), holds_dir(T, QVar2, Dir2), Dir1 != Dir2.
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mplus(QVar1, QVar2)), holds(T, QVar1, QMag1, Dir), holds(T, QVar2, QMag2, Dir), 
       correspond(Name, Corr1, Corr2),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       Sign1 != Sign2.

% M-(X,Y)
% correspond(Name, X, Y)
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, mminus(QVar1, QVar2)), holds_dir(T, QVar1, Dir1), holds_dir(T, QVar2, Dir2), 
       not qdirNeg(Dir1, Dir2).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mminus(QVar1, QVar2)), holds(T, QVar1, QMag1, Dir1), holds(T, QVar2, QMag2, Dir2), 
       qdirNeg(Dir1, Dir2),
       correspond(Name, Corr1, Corr2),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       not mminus_signs(Sign1, Sign2).

% deriv(X, Y): Y is the derivative of X
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, deriv(QVar1, QVar2)), holds_dir(T, QVar1, Dir1), holds_mag(T, QVar2, QMag2),
       qdir(Dir1, Sign1),
       relative_qmag(QVar2, QMag2, land(zero), Sign2),
       Sign1 != Sign2.

% qnull - can never hold
:- 1 {T = p(t); T = i(T1,t) } 1, holds_constraint(T, qnull).

% Mult(X, Y, Z): Z = X * Y
% qmult_corr is the allowable list of sign combinations for corresponding values in each
%    of the 4 cases

:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, mult(QVar1, QVar2, QVar3)), holds(T, QVar1, QMag1, Dir1), holds(T, QVar2, QMag2, Dir2), holds(T, QVar3, QMag3, Dir3),
       relative_qmag(QVar1, QMag1, land(zero), Sign1),
       relative_qmag(QVar2, QMag2, land(zero), Sign2),
       relative_qmag(QVar3, QMag3, land(zero), Sign3),
       not qmult(Sign1, Sign2, Sign3, Dir1, Dir2, Dir3).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, mult(QVar1, _, QVar3)), holds_mag(T, QVar1, land(zero)), holds_mag(T, QVar3, QMag3),
       QMag3 != land(zero).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, mult(_, QVar2, QVar3)), holds_mag(T, QVar2, land(zero)), holds_mag(T, QVar3, QMag3),
       QMag3 != land(zero).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mult(QVar1, QVar2, QVar3)), holds_mag(T, QVar1, QMag1), holds_mag(T, QVar2, QMag2), holds_mag(T, QVar3, QMag3),
       %% Both Pos
       relative_qmag(QVar1, QMag1, land(zero), pos),
       relative_qmag(QVar2, QMag2, land(zero), pos),
       correspond_mult(Name, Corr1, Corr2, Corr3),
       relative_qmag(QVar1, Corr1, land(zero), pos),
       relative_qmag(QVar2, Corr2, land(zero), pos),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       relative_qmag(QVar3, QMag3, Corr3, Sign3),
       not qmult_corr(both_pos, Sign1, Sign2, Sign3).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mult(QVar1, QVar2, QVar3)), holds_mag(T, QVar1, QMag1), holds_mag(T, QVar2, QMag2), holds_mag(T, QVar3, QMag3),
       %% Both Neg
       relative_qmag(QVar1, QMag1, land(zero), neg),
       relative_qmag(QVar2, QMag2, land(zero), neg),
       correspond_mult(Name, Corr1, Corr2, Corr3),
       relative_qmag(QVar1, Corr1, land(zero), neg),
       relative_qmag(QVar2, Corr2, land(zero), neg),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       relative_qmag(QVar3, QMag3, Corr3, Sign3),
       not qmult_corr(both_neg, Sign1, Sign2, Sign3).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mult(QVar1, QVar2, QVar3)), holds_mag(T, QVar1, QMag1), holds_mag(T, QVar2, QMag2), holds_mag(T, QVar3, QMag3),
       %% QM1 < 0, QM2 > 0
       relative_qmag(QVar1, QMag1, land(zero), neg),
       relative_qmag(QVar2, QMag2, land(zero), pos),
       correspond_mult(Name, Corr1, Corr2, Corr3),
       relative_qmag(QVar1, Corr1, land(zero), neg),
       relative_qmag(QVar2, Corr2, land(zero), pos),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       relative_qmag(QVar3, QMag3, Corr3, Sign3),
       not qmult_corr(neg_pos, Sign1, Sign2, Sign3).
:- 1 {T = p(t); T = i(T1,t) } 1,
   holds_constraint(T, Name, mult(QVar1, QVar2, QVar3)), holds_mag(T, QVar1, QMag1), holds_mag(T, QVar2, QMag2), holds_mag(T, QVar3, QMag3),
       %% QM1 > 0, QM2 < 0
       relative_qmag(QVar1, QMag1, land(zero), pos),
       relative_qmag(QVar2, QMag2, land(zero), neg),
       correspond_mult(Name, Corr1, Corr2, Corr3),
       relative_qmag(QVar1, Corr1, land(zero), pos),
       relative_qmag(QVar2, Corr2, land(zero), neg),
       relative_qmag(QVar1, QMag1, Corr1, Sign1),
       relative_qmag(QVar2, QMag2, Corr2, Sign2),
       relative_qmag(QVar3, QMag3, Corr3, Sign3),
       not qmult_corr(pos_neg, Sign1, Sign2, Sign3).

