%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Goals - Bathtub
%

%%% Initial State
init(volume,land(zero),std).
init(inflow,land(zero),std).

%%% Goal State
goal(level,land(top),std).

%%%%%%%%%%%%%%%%%%%%
% End of Plan - ASP
%%%%%%%%%%%%%%%%%%%%

