%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Goals - Ball
%

%%% Initial State
init(y,land(zero),inc).
init(v,land(vv),dec).
init(a,land(aa),std).

%%% Goal State
goal(y,land(zero),dec).

%%%%%%%%%%%%%%%%%%%%
% End of Plan - ASP
%%%%%%%%%%%%%%%%%%%%

