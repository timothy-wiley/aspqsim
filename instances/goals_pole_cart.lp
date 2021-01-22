%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% Goals - Pole & Cart
%

%%% Initial State
init(a,land(zero),std).
init(angle_pole_a,land(zero),std).
init(x_dot,land(zero),std).
init(angle_pole_dot,land(zero),std).
init(x,land(x_0),std).
init(angle_pole,land(zero),std).

%%% Goal State
goal(x_dot,land(zero),std).
goal(x,land(x_goal),std).

%%%%%%%%%%%%%%%%%%%%
% End of Plan - ASP
%%%%%%%%%%%%%%%%%%%%

