%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% bathtub_db Database
%

%%% QVars
qvar(volume).
qvar(level).
qvar(pressure).
qvar(outflow).
qvar(inflow).
qvar(netflow).

%%% Discrete

%%% landmarks
landmark(volume,zero).
landmark(volume,full).
landmark(level,zero).
landmark(level,top).
landmark(level,inf).
landmark(pressure,zero).
landmark(pressure,inf).
landmark(outflow,zero).
landmark(outflow,inf).
landmark(inflow,zero).
landmark(inflow,if).
landmark(inflow,inf).
landmark(netflow,minf).
landmark(netflow,zero).
landmark(netflow,inf).

%%% adjacent_landmark
adjacent_landmark(volume,zero,full).
adjacent_landmark(level,zero,top).
adjacent_landmark(level,top,inf).
adjacent_landmark(pressure,zero,inf).
adjacent_landmark(outflow,zero,inf).
adjacent_landmark(inflow,zero,if).
adjacent_landmark(inflow,if,inf).
adjacent_landmark(netflow,minf,zero).
adjacent_landmark(netflow,zero,inf).

%%%%%%%%%%%%%%%%%%%%
%% Region and Rules
%%%%%%%%%%%%%%%%%%%%

%%% Landmark Rules
rule(all, all, mplus(volume,level)).
rule(all_1, all, mplus(level,pressure)).
rule(all_2, all, mplus(pressure,outflow)).
rule(all_3, all, sum(netflow,outflow,inflow)).
rule(all_4, all, deriv(volume,netflow)).

%%% Correspond
correspond(all,land(zero),land(zero)).
correspond(all,land(full),land(top)).
correspond(all_1,land(zero),land(zero)).
correspond(all_1,land(inf),land(inf)).
correspond(all_2,land(zero),land(zero)).
correspond(all_2,land(inf),land(inf)).
correspond_sum(all_3,land(zero),land(zero),land(zero)).
correspond_sum(all_3,land(zero),land(zero),land(zero)).

%%% Preconditions
% Precondition all
precond(all, true).


%%%%%%%%%%%%%%%%%%%%
% End of Database - ASP
%%%%%%%%%%%%%%%%%%%%

