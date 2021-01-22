%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Collection of various predicates/facts
%

#program base.

% Qualitative directions
qdir(std).
qdir(inc).
qdir(dec).

% Inverts the qualitative direction
qinvert(pos, neg).
qinvert(zero, zero).
qinvert(neg, pos).

% Qdir is qualitative direction of change with sign Sign
% qdir(Qdir, Sign):
qdir(dec, neg).
qdir(std, zero).
qdir(inc, pos).

% Qualitative direction negations
% qdirNeg(?QDir1, ?QDir2)
qdirNeg(dec, inc).
qdirNeg(std, std).
qdirNeg(inc, dec).

% Laws of qualitative summation
%  qsum(Q1, Q2, Q3):
%    Q3 = Q1 + Q2, qualitative sum over domain [pos,zero,neg]
qsum(pos, pos, pos).
qsum(pos, zero, pos).
qsum(pos, neg, pos).
qsum(pos, neg, zero).
qsum(pos, neg, neg).
qsum(zero, pos, pos).
qsum(zero, zero, zero).
qsum(zero, neg, neg).
qsum(neg, pos, pos).
qsum(neg, pos, zero).
qsum(neg, pos, neg). 
qsum(neg, zero, neg).
qsum(neg, neg, neg).

%  qdirsum(D1, D2, D3):
%    qualitative sum over directions of change
qdirsum(D1, D2, D3)  :-
   qdir(D1, Q1),
   qdir(D2, Q2),
   qdir(D3, Q3),
   qsum(Q1, Q2, Q3).

% Qualitative M- inverted signs
mminus_signs(zero, zero).
mminus_signs(pos, neg).
mminus_signs(neg, pos).

% Laws for qualitative multiplication
% qmult(Sign1, Sign2, Sign3, D1, D2, D3)
%   Signx := [pos, zero, neg] relative to zero
%   Q1 * Q2 = Q3
qmult(pos, pos, pos, inc, inc, inc).
qmult(pos, pos, pos, inc, std, inc).
qmult(pos, pos, pos, inc, dec, Dir) :- qdir(Dir).
qmult(pos, pos, pos, std, inc, inc).
qmult(pos, pos, pos, std, std, std).
qmult(pos, pos, pos, std, dec, dec).
qmult(pos, pos, pos, dec, inc, Dir) :- qdir(Dir).
qmult(pos, pos, pos, dec, std, dec).
qmult(pos, pos, pos, dec, dec, dec).

qmult(pos, zero, zero, Dir1, Dir2, Dir2) :- qdir(Dir1), qdir(Dir2).

qmult(pos, neg, neg, inc, inc, Dir) :- qdir(Dir).
qmult(pos, neg, neg, inc, std, dec).
qmult(pos, neg, neg, inc, dec, dec).
qmult(pos, neg, neg, std, inc, inc).
qmult(pos, neg, neg, std, std, std).
qmult(pos, neg, neg, std, dec, dec).
qmult(pos, neg, neg, dec, inc, inc).
qmult(pos, neg, neg, dec, std, inc).
qmult(pos, neg, neg, dec, dec, Dir) :- qdir(Dir).

qmult(zero, pos, zero, Dir1, Dir2, Dir1) :- qdir(Dir1), qdir(Dir2).

qmult(zero, zero, zero, Dir1, Dir2, std) :- qdir(Dir1), qdir(Dir2).

qmult(zero, neg, zero, inc, Dir, dec) :- qdir(Dir).
qmult(zero, neg, zero, std, Dir, std) :- qdir(Dir).
qmult(zero, neg, zero, dec, Dir, inc) :- qdir(Dir).

qmult(neg, pos, neg, inc, inc, Dir) :- qdir(Dir).
qmult(neg, pos, neg, inc, std, inc).
qmult(neg, pos, neg, inc, dec, inc).
qmult(neg, pos, neg, std, inc, dec).
qmult(neg, pos, neg, std, std, std).
qmult(neg, pos, neg, std, dec, inc).
qmult(neg, pos, neg, dec, inc, dec).
qmult(neg, pos, neg, dec, std, dec).
qmult(neg, pos, neg, dec, dec, Dir) :- qdir(Dir).

qmult(neg, zero, zero, Dir1, Dir2, Dir3) :- qdir(Dir1), qdirNeg(Dir2, Dir3).

qmult(neg, neg, pos, inc, inc, dec).
qmult(neg, neg, pos, inc, std, dec).
qmult(neg, neg, pos, inc, dec, Dir) :- qdir(Dir).
qmult(neg, neg, pos, std, inc, dec).
qmult(neg, neg, pos, std, std, std).
qmult(neg, neg, pos, std, dec, inc).
qmult(neg, neg, pos, dec, inc, Dir) :- qdir(Dir).
qmult(neg, neg, pos, dec, std, inc).
qmult(neg, neg, pos, dec, dec, inc).

% Qual Multiplication qualitative values
qmult_corr(both_pos, zero, zero, zero).
qmult_corr(both_pos, zero, pos, pos).
qmult_corr(both_pos, zero, neg, neg).
qmult_corr(both_pos, pos, zero, pos).
qmult_corr(both_pos, pos, pos, pos).
qmult_corr(both_pos, pos, neg, zero).
qmult_corr(both_pos, pos, neg, pos).
qmult_corr(both_pos, pos, neg, neg).
qmult_corr(both_pos, neg, zero, neg).
qmult_corr(both_pos, neg, pos, zero).
qmult_corr(both_pos, neg, pos, pos).
qmult_corr(both_pos, neg, pos, neg).
qmult_corr(both_pos, neg, neg, neg).
qmult_corr(both_neg, zero, zero, zero).
qmult_corr(both_neg, zero, pos, neg).
qmult_corr(both_neg, zero, neg, pos).
qmult_corr(both_neg, pos, zero, neg).
qmult_corr(both_neg, pos, pos, neg).
qmult_corr(both_neg, pos, neg, zero).
qmult_corr(both_neg, pos, neg, pos).
qmult_corr(both_neg, pos, neg, neg).
qmult_corr(both_neg, neg, zero, pos).
qmult_corr(both_neg, neg, pos, zero).
qmult_corr(both_neg, neg, pos, pos).
qmult_corr(both_neg, neg, pos, neg).
qmult_corr(both_neg, neg, neg, pos).
qmult_corr(neg_pos, zero, zero, zero).
qmult_corr(neg_pos, zero, pos, neg).
qmult_corr(neg_pos, zero, neg, pos).
qmult_corr(neg_pos, pos, zero, pos).
qmult_corr(neg_pos, pos, pos, zero).
qmult_corr(neg_pos, pos, pos, pos).
qmult_corr(neg_pos, pos, pos, neg).
qmult_corr(neg_pos, pos, neg, pos).
qmult_corr(neg_pos, neg, zero, neg).
qmult_corr(neg_pos, neg, pos, neg).
qmult_corr(neg_pos, neg, neg, zero).
qmult_corr(neg_pos, neg, neg, pos).
qmult_corr(neg_pos, neg, neg, neg).
qmult_corr(pos_neg, zero, zero, zero).
qmult_corr(pos_neg, zero, pos, pos).
qmult_corr(pos_neg, zero, neg, neg).
qmult_corr(pos_neg, pos, zero, neg).
qmult_corr(pos_neg, pos, pos, zero).
qmult_corr(pos_neg, pos, pos, pos).
qmult_corr(pos_neg, pos, pos, neg).
qmult_corr(pos_neg, pos, neg, neg).
qmult_corr(pos_neg, neg, zero, pos).
qmult_corr(pos_neg, neg, pos, pos).
qmult_corr(pos_neg, neg, neg, zero).
qmult_corr(pos_neg, neg, neg, pos).
qmult_corr(pos_neg, neg, neg, neg).

% Precondition bound checking
precond_bound_lower(e, pos).
precond_bound_lower(i, pos).
precond_bound_lower(i, zero).
precond_bound_upper(e, neg).
precond_bound_upper(i, neg).
precond_bound_upper(i, zero).

