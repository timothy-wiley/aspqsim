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
qvar(level4).
qvar(netflow4).
qvar(outflow4).
qvar(level5).
qvar(netflow5).
qvar(outflow5).
qvar(level6).
qvar(netflow6).
qvar(outflow6).
qvar(level7).
qvar(netflow7).
qvar(outflow7).
qvar(level8).
qvar(netflow8).
qvar(outflow8).
qvar(level9).
qvar(netflow9).
qvar(outflow9).
qvar(level10).
qvar(netflow10).
qvar(outflow10).

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
landmark(level4,zero).
landmark(level4,half).
landmark(level4,full).
landmark(netflow4,min).
landmark(netflow4,zero).
landmark(netflow4,max).
landmark(outflow4,zero).
landmark(outflow4,max).
landmark(level5,zero).
landmark(level5,half).
landmark(level5,full).
landmark(netflow5,min).
landmark(netflow5,zero).
landmark(netflow5,max).
landmark(outflow5,zero).
landmark(outflow5,max).
landmark(level6,zero).
landmark(level6,half).
landmark(level6,full).
landmark(netflow6,min).
landmark(netflow6,zero).
landmark(netflow6,max).
landmark(outflow6,zero).
landmark(outflow6,max).
landmark(level7,zero).
landmark(level7,half).
landmark(level7,full).
landmark(netflow7,min).
landmark(netflow7,zero).
landmark(netflow7,max).
landmark(outflow7,zero).
landmark(outflow7,max).
landmark(level8,zero).
landmark(level8,half).
landmark(level8,full).
landmark(netflow8,min).
landmark(netflow8,zero).
landmark(netflow8,max).
landmark(outflow8,zero).
landmark(outflow8,max).
landmark(level9,zero).
landmark(level9,half).
landmark(level9,full).
landmark(netflow9,min).
landmark(netflow9,zero).
landmark(netflow9,max).
landmark(outflow9,zero).
landmark(outflow9,max).
landmark(level10,zero).
landmark(level10,half).
landmark(level10,full).
landmark(netflow10,min).
landmark(netflow10,zero).
landmark(netflow10,max).
landmark(outflow10,zero).
landmark(outflow10,max).

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
adjacent_landmark(level4,zero,half).
adjacent_landmark(level4,half,full).
adjacent_landmark(netflow4,min,zero).
adjacent_landmark(netflow4,zero,max).
adjacent_landmark(outflow4,zero,max).
adjacent_landmark(level5,zero,half).
adjacent_landmark(level5,half,full).
adjacent_landmark(netflow5,min,zero).
adjacent_landmark(netflow5,zero,max).
adjacent_landmark(outflow5,zero,max).
adjacent_landmark(level6,zero,half).
adjacent_landmark(level6,half,full).
adjacent_landmark(netflow6,min,zero).
adjacent_landmark(netflow6,zero,max).
adjacent_landmark(outflow6,zero,max).
adjacent_landmark(level7,zero,half).
adjacent_landmark(level7,half,full).
adjacent_landmark(netflow7,min,zero).
adjacent_landmark(netflow7,zero,max).
adjacent_landmark(outflow7,zero,max).
adjacent_landmark(level8,zero,half).
adjacent_landmark(level8,half,full).
adjacent_landmark(netflow8,min,zero).
adjacent_landmark(netflow8,zero,max).
adjacent_landmark(outflow8,zero,max).
adjacent_landmark(level9,zero,half).
adjacent_landmark(level9,half,full).
adjacent_landmark(netflow9,min,zero).
adjacent_landmark(netflow9,zero,max).
adjacent_landmark(outflow9,zero,max).
adjacent_landmark(level10,zero,half).
adjacent_landmark(level10,half,full).
adjacent_landmark(netflow10,min,zero).
adjacent_landmark(netflow10,zero,max).
adjacent_landmark(outflow10,zero,max).

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
rule(tank4, tank4, mplus(netflow4,level4)).
rule(tank4_1, tank4, sum(netflow4,outflow4,outflow3)).
rule(tank4_2, tank4, deriv(level4,netflow4)).
rule(tank4_no_outflow, tank4_no_outflow, const(outflow4,land(zero))).
rule(tank4_outflow, tank4_outflow, mplus(outflow4,level4)).
rule(tank5, tank5, mplus(netflow5,level5)).
rule(tank5_1, tank5, sum(netflow5,outflow5,outflow3)).
rule(tank5_2, tank5, deriv(level5,netflow5)).
rule(tank5_no_outflow, tank5_no_outflow, const(outflow5,land(zero))).
rule(tank5_outflow, tank5_outflow, mplus(outflow5,level5)).
rule(tank6, tank6, mplus(netflow6,level6)).
rule(tank6_1, tank6, sum(netflow6,outflow6,outflow5)).
rule(tank6_2, tank6, deriv(level6,netflow6)).
rule(tank6_no_outflow, tank6_no_outflow, const(outflow6,land(zero))).
rule(tank6_outflow, tank6_outflow, mplus(outflow6,level6)).
rule(tank7, tank7, mplus(netflow7,level7)).
rule(tank7_1, tank7, sum(netflow7,outflow7,outflow6)).
rule(tank7_2, tank7, deriv(level7,netflow7)).
rule(tank7_no_outflow, tank7_no_outflow, const(outflow7,land(zero))).
rule(tank7_outflow, tank7_outflow, mplus(outflow7,level7)).
rule(tank8, tank8, mplus(netflow8,level8)).
rule(tank8_1, tank8, sum(netflow8,outflow8,outflow7)).
rule(tank8_2, tank8, deriv(level8,netflow8)).
rule(tank8_no_outflow, tank8_no_outflow, const(outflow8,land(zero))).
rule(tank8_outflow, tank8_outflow, mplus(outflow8,level8)).
rule(tank9, tank9, mplus(netflow9,level9)).
rule(tank9_1, tank9, sum(netflow9,outflow9,outflow8)).
rule(tank9_2, tank9, deriv(level9,netflow9)).
rule(tank9_no_outflow, tank9_no_outflow, const(outflow9,land(zero))).
rule(tank9_outflow, tank9_outflow, mplus(outflow9,level9)).
rule(tank10, tank10, mplus(netflow10,level10)).
rule(tank10_1, tank10, sum(netflow10,outflow10,outflow9)).
rule(tank10_2, tank10, deriv(level10,netflow10)).
rule(tank10_no_outflow, tank10_no_outflow, const(outflow10,land(zero))).
rule(tank10_outflow, tank10_outflow, mplus(outflow10,level10)).

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
correspond_sum(tank4_1,land(zero),land(zero),land(zero)).
correspond_sum(tank4_1,land(zero),land(zero),land(zero)).
correspond(tank4_outflow,land(zero),land(half)).
correspond(tank4_outflow,land(max),land(full)).
correspond_sum(tank5_1,land(zero),land(zero),land(zero)).
correspond_sum(tank5_1,land(zero),land(zero),land(zero)).
correspond(tank5_outflow,land(zero),land(half)).
correspond(tank5_outflow,land(max),land(full)).
correspond_sum(tank6_1,land(zero),land(zero),land(zero)).
correspond_sum(tank6_1,land(zero),land(zero),land(zero)).
correspond(tank6_outflow,land(zero),land(half)).
correspond(tank6_outflow,land(max),land(full)).
correspond_sum(tank7_1,land(zero),land(zero),land(zero)).
correspond_sum(tank7_1,land(zero),land(zero),land(zero)).
correspond(tank7_outflow,land(zero),land(half)).
correspond(tank7_outflow,land(max),land(full)).
correspond_sum(tank8_1,land(zero),land(zero),land(zero)).
correspond_sum(tank8_1,land(zero),land(zero),land(zero)).
correspond(tank8_outflow,land(zero),land(half)).
correspond(tank8_outflow,land(max),land(full)).
correspond_sum(tank9_1,land(zero),land(zero),land(zero)).
correspond_sum(tank9_1,land(zero),land(zero),land(zero)).
correspond(tank9_outflow,land(zero),land(half)).
correspond(tank9_outflow,land(max),land(full)).
correspond_sum(tank10_1,land(zero),land(zero),land(zero)).
correspond_sum(tank10_1,land(zero),land(zero),land(zero)).
correspond(tank10_outflow,land(zero),land(half)).
correspond(tank10_outflow,land(max),land(full)).

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

% Precondition tank4
precond(tank4, true).

% Precondition tank4_no_outflow
precond(tank4_no_outflow, bound, level4, i, zero, e, half).

% Precondition tank4_outflow
precond(tank4_outflow, bound, level4, e, half, i, full).

% Precondition tank5
precond(tank5, true).

% Precondition tank5_no_outflow
precond(tank5_no_outflow, bound, level5, i, zero, e, half).

% Precondition tank5_outflow
precond(tank5_outflow, bound, level5, e, half, i, full).

% Precondition tank6
precond(tank6, true).

% Precondition tank6_no_outflow
precond(tank6_no_outflow, bound, level6, i, zero, e, half).

% Precondition tank6_outflow
precond(tank6_outflow, bound, level6, e, half, i, full).

% Precondition tank7
precond(tank7, true).

% Precondition tank7_no_outflow
precond(tank7_no_outflow, bound, level7, i, zero, e, half).

% Precondition tank7_outflow
precond(tank7_outflow, bound, level7, e, half, i, full).

% Precondition tank8
precond(tank8, true).

% Precondition tank8_no_outflow
precond(tank8_no_outflow, bound, level8, i, zero, e, half).

% Precondition tank8_outflow
precond(tank8_outflow, bound, level8, e, half, i, full).

% Precondition tank9
precond(tank9, true).

% Precondition tank9_no_outflow
precond(tank9_no_outflow, bound, level9, i, zero, e, half).

% Precondition tank9_outflow
precond(tank9_outflow, bound, level9, e, half, i, full).

% Precondition tank10
precond(tank10, true).

% Precondition tank10_no_outflow
precond(tank10_no_outflow, bound, level10, i, zero, e, half).

% Precondition tank10_outflow
precond(tank10_outflow, bound, level10, e, half, i, full).


%%%%%%%%%%%%%%%%%%%%
% End of Database - ASP
%%%%%%%%%%%%%%%%%%%%

