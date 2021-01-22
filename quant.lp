%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Quantitative Integrity Constraints
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quantiative Constraints

#program base.

% Dummy values for inf/minf
#const infinity=1000.
landmark_value(QVar, minf, -infinity) :- qvar(QVar).
landmark_value(QVar, inf, infinity) :- qvar(QVar).

% project landmark value
landmark_value(V,L) :- landmark_value(V,L,X).

% Gives the upper/lower bounds on each unknown landmark value
landmark_value_upper(QVar, land(L1), Upper)   :- landmark_value(QVar, L1, Upper), L1==minf.
landmark_value_upper(QVar, land(L1), Upper)   :- landmark_value(QVar, L1, Upper), L1==inf.
landmark_value_lower(QVar, land(L1), Lower)   :- landmark_value(QVar, L1, Lower), L1==minf.
landmark_value_lower(QVar, land(L1), Lower)   :- landmark_value(QVar, L1, Lower), L1==inf.

landmark_value_upper(QVar, land(L1), Upper)   :- qmag(QVar, land(L1)), landmark_value(QVar, L1, Upper).
landmark_value_upper(QVar, land(L1), Upper-1) :- qmag(QVar, land(L1)), not landmark_value(QVar,L1), adjacent_landmark(QVar, L1, L2),
                                                 landmark_value_upper(QVar, land(L2), Upper).
landmark_value_upper(QVar, land(L1), Upper-1) :- qmag(QVar, land(L1)), not landmark_value(QVar,L1), last_landmark(QVar, L1),
                                                 landmark_value_upper(QVar, land(inf), Upper).
landmark_value_lower(QVar, land(L1), Lower)   :- qmag(QVar, land(L1)), landmark_value(QVar, L1, Lower).
landmark_value_lower(QVar, land(L1), Lower+1) :- qmag(QVar, land(L1)), not landmark_value(QVar,L1), adjacent_landmark(QVar, L0, L1),
                                                 landmark_value_lower(QVar, land(L0), Lower).
landmark_value_lower(QVar, land(L1), Lower+1) :- qmag(QVar, land(L1)), not landmark_value(QVar,L1), first_landmark(QVar,L1),
                                                 landmark_value_lower(QVar, land(minf), Lower).

landmark_value_lower(QVar, interval(L1, L2), L) :- qmag(QVar, interval(L1, L2)), landmark_value_lower(QVar, land(L1), L).
landmark_value_upper(QVar, interval(L1, L2), U) :- qmag(QVar, interval(L1, L2)), landmark_value_upper(QVar, land(L2), U).


% restrict the domain statically
L $<= $quant(T,V) $<= U :- first_landmark(V,M1), landmark_value_lower(V, land(M1), L), last_landmark(V,M2), landmark_value_upper(V, land(M2), U), time(T).

% restrict the domain dynamically
L $<= $quant(T,V1) $<= U:- holds_mag(T,V1,M1), landmark_value_lower(V1, M1, L), landmark_value_upper(V1, M1, U).

% sum constraint
#program cumulative(t).
:- holds_constraint(T,sum(V1, V2, V3)), $quant(T,V1) $+ $quant(T,V2) $!= $quant(T,V3).

% some symmetry breaking, if the constraint is not active,
%  the variables do have the lowest value
%  WATCHOUT, THIS IS ONLY POSSIBLE IF ALL CONSTRAINTS THAT CHANGE THE VARIABLE ARE FALSE
%$quant(T,V1) $== L :- not holds_constraint(T,sum(V1, V2, V3)), rule(_,_,sum(V1,V2,V3)), time(T),  first_landmark(V1,M1), landmark_value_lower(V1, land(M1), L).
%$quant(T,V2) $== L :- not holds_constraint(T,sum(V1, V2, V3)), rule(_,_,sum(V1,V2,V3)), time(T),  first_landmark(V2,M1), landmark_value_lower(V2, land(M1), L).
%$quant(T,V3) $== L :- not holds_constraint(T,sum(V1, V2, V3)), rule(_,_,sum(V1,V2,V3)), time(T),  first_landmark(V3,M1), landmark_value_lower(V3, land(M1), L).
   
