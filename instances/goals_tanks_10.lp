%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Goals - Tanks 10
%

%%% Initial State
init(inflow,land(zero),std).
init(level1,land(zero),std).
init(level2,land(zero),std).
init(level3,land(zero),std).
init(level4,land(zero),std).
init(level5,land(zero),std).
init(level6,land(zero),std).
init(level7,land(zero),std).
init(level8,land(zero),std).
init(level9,land(zero),std).
init(level10,land(zero),std).

%%% Goal State
%goal(level1,land(full),inc).
%goal(level2,land(full),inc).
%goal(level3,land(full),inc).
%goal(level4,land(full),inc).
%goal(level5,land(full),inc).
%goal(level6,land(full),inc).
%goal(level7,land(full),inc).
%goal(level8,land(full),inc).
%goal(level9,land(full),inc).
goal(level10,land(full),inc).

%%%%%%%%%%%%%%%%%%%%
% End of Plan - ASP
%%%%%%%%%%%%%%%%%%%%

