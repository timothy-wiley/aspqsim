%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% tanks Database
%

%%% QVars
#program base.
qvar(inflow).
qvar(level1).
qvar(netflow1).
qvar(outflow1).
qvar(level2).
qvar(netflow2).
qvar(outflow2).
qvar(level3).
qvar(netflow3).
qvar(outflow3).

%%% Discrete
#program base.

%%% Control
#program base.
control(inflow).

%%% landmarks
#program base.
landmark(inflow,zero).
landmark(inflow,max).
landmark(level1,zero).
landmark(level1,half).
landmark(level1,full).
landmark(netflow1,min).
landmark(netflow1,zero).
landmark(netflow1,max).
landmark(outflow1,zero).
landmark(outflow1,max).
landmark(level2,zero).
landmark(level2,half).
landmark(level2,full).
landmark(netflow2,min).
landmark(netflow2,zero).
landmark(netflow2,max).
landmark(outflow2,zero).
landmark(outflow2,max).
landmark(level3,zero).
landmark(level3,half).
landmark(level3,full).
landmark(netflow3,min).
landmark(netflow3,zero).
landmark(netflow3,max).
landmark(outflow3,zero).
landmark(outflow3,max).

%%% adjacent_landmark
#program base.
adjacent_landmark(inflow,zero,max).
adjacent_landmark(level1,zero,half).
adjacent_landmark(level1,half,full).
adjacent_landmark(netflow1,min,zero).
adjacent_landmark(netflow1,zero,max).
adjacent_landmark(outflow1,zero,max).
adjacent_landmark(level2,zero,half).
adjacent_landmark(level2,half,full).
adjacent_landmark(netflow2,min,zero).
adjacent_landmark(netflow2,zero,max).
adjacent_landmark(outflow2,zero,max).
adjacent_landmark(level3,zero,half).
adjacent_landmark(level3,half,full).
adjacent_landmark(netflow3,min,zero).
adjacent_landmark(netflow3,zero,max).
adjacent_landmark(outflow3,zero,max).

%%% Landmark Values
#program base.

%%%%%%%%%%%%%%%%%%%%
%% Region and Rules
%%%%%%%%%%%%%%%%%%%%

%%% Landmark Rules
#program base.
rule(tank1, tank1, mplus(netflow1,level1)).
rule(tank1_1, tank1, sum(netflow1,outflow1,inflow)).
rule(tank1_2, tank1, deriv(level1,netflow1)).
rule(tank1_no_outflow, tank1_no_outflow, const(outflow1,land(zero))).
rule(tank1_outflow, tank1_outflow, mplus(outflow1,level1)).
rule(tank2, tank2, mplus(netflow2,level2)).
rule(tank2_1, tank2, sum(netflow2,outflow2,outflow1)).
rule(tank2_2, tank2, deriv(level2,netflow2)).
rule(tank2_no_outflow, tank2_no_outflow, const(outflow2,land(zero))).
rule(tank2_outflow, tank2_outflow, mplus(outflow2,level2)).
rule(tank3, tank3, mplus(netflow3,level3)).
rule(tank3_1, tank3, sum(netflow3,outflow3,outflow2)).
rule(tank3_2, tank3, deriv(level3,netflow3)).
rule(tank3_no_outflow, tank3_no_outflow, const(outflow3,land(zero))).
rule(tank3_outflow, tank3_outflow, mplus(outflow3,level3)).

%%% Correspond
#program base.
correspond_sum(tank1_1,land(zero),land(zero),land(zero)).
correspond_sum(tank1_1,land(zero),land(zero),land(zero)).
correspond(tank1_outflow,land(zero),land(half)).
correspond(tank1_outflow,land(max),land(full)).
correspond_sum(tank2_1,land(zero),land(zero),land(zero)).
correspond_sum(tank2_1,land(zero),land(zero),land(zero)).
correspond(tank2_outflow,land(zero),land(half)).
correspond(tank2_outflow,land(max),land(full)).
correspond_sum(tank3_1,land(zero),land(zero),land(zero)).
correspond_sum(tank3_1,land(zero),land(zero),land(zero)).
correspond(tank3_outflow,land(zero),land(half)).
correspond(tank3_outflow,land(max),land(full)).

%%% Preconditions
#program base.
% Precondition tank1
precond(tank1, true).

% Precondition tank1_no_outflow
precond(tank1_no_outflow, bound, level1, i, zero, e, half).

% Precondition tank1_outflow
precond(tank1_outflow, bound, level1, e, half, i, full).

% Precondition tank2
precond(tank2, true).

% Precondition tank2_no_outflow
precond(tank2_no_outflow, bound, level2, i, zero, e, half).

% Precondition tank2_outflow
precond(tank2_outflow, bound, level2, e, half, i, full).

% Precondition tank3
precond(tank3, true).

% Precondition tank3_no_outflow
precond(tank3_no_outflow, bound, level3, i, zero, e, half).

% Precondition tank3_outflow
precond(tank3_outflow, bound, level3, e, half, i, full).


%%%%%%%%%%%%%%%%%%%%
% End of Database - ASP
%%%%%%%%%%%%%%%%%%%%

