%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Goals - Tanks 3
%

%%% Initial State
init(inflow,land(zero),std).
init(level1,land(zero),std).
init(level2,land(zero),std).
init(level3,land(zero),std).

%%% Goal State
%goal(level1,land(full),inc).
%goal(level2,land(full),inc).
goal(level3,land(full),inc).
%init(inflow,land(zero),std).

%%%%%%%%%%%%%%%%%%%%
% End of Plan - ASP
%%%%%%%%%%%%%%%%%%%%

