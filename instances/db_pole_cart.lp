%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
% pole_cart_db Database
%

%%% QVars
qvar(a).
qvar(angle_pole_a).
qvar(x_dot).
qvar(angle_pole_dot).
qvar(x).
qvar(angle_pole).
qvar(g).
qvar(ng).

%%% Discrete

%%% Control
control(a).

%%% landmarks
landmark(a,reverse).
landmark(a,zero).
landmark(a,forward).
landmark(angle_pole_a,a_pole_min).
landmark(angle_pole_a,zero).
landmark(angle_pole_a,a_pole_max).
landmark(x_dot,v_min).
landmark(x_dot,zero).
landmark(x_dot,v_max).
landmark(angle_pole_dot,v_pole_min).
landmark(angle_pole_dot,zero).
landmark(angle_pole_dot,v_pole_max).
landmark(x,ntable).
landmark(x,x_0).
landmark(x,x_goal).
landmark(x,table).
landmark(angle_pole,npi2).
landmark(angle_pole,nlimit).
landmark(angle_pole,zero).
landmark(angle_pole,limit).
landmark(angle_pole,pi2).
landmark(g,zero).
landmark(g,earth).
landmark(ng,nearth).
landmark(ng,zero).

%%% adjacent_landmark
adjacent_landmark(a,reverse,zero).
adjacent_landmark(a,zero,forward).
adjacent_landmark(angle_pole_a,a_pole_min,zero).
adjacent_landmark(angle_pole_a,zero,a_pole_max).
adjacent_landmark(x_dot,v_min,zero).
adjacent_landmark(x_dot,zero,v_max).
adjacent_landmark(angle_pole_dot,v_pole_min,zero).
adjacent_landmark(angle_pole_dot,zero,v_pole_max).
adjacent_landmark(x,ntable,x_0).
adjacent_landmark(x,x_0,x_goal).
adjacent_landmark(x,x_goal,table).
adjacent_landmark(angle_pole,npi2,nlimit).
adjacent_landmark(angle_pole,nlimit,zero).
adjacent_landmark(angle_pole,zero,limit).
adjacent_landmark(angle_pole,limit,pi2).
adjacent_landmark(g,zero,earth).
adjacent_landmark(ng,nearth,zero).

%%% Landmark Values
landmark_value(a,reverse,-1).
landmark_value(a,zero,0).
landmark_value(a,forward,1).
landmark_value(angle_pole_a,a_pole_min,-15).
landmark_value(angle_pole_a,zero,0).
landmark_value(angle_pole_a,a_pole_max,15).
landmark_value(x_dot,v_min,-30).
landmark_value(x_dot,zero,0).
landmark_value(x_dot,v_max,30).
landmark_value(angle_pole_dot,v_pole_min,-30).
landmark_value(angle_pole_dot,zero,0).
landmark_value(angle_pole_dot,v_pole_max,30).
landmark_value(x,ntable,-100).
landmark_value(x,x_0,0).
landmark_value(x,x_goal,1).
landmark_value(x,table,100).
landmark_value(angle_pole,npi2,-90).
landmark_value(angle_pole,nlimit,-20).
landmark_value(angle_pole,zero,0).
landmark_value(angle_pole,limit,20).
landmark_value(angle_pole,pi2,90).
landmark_value(g,zero,0).
landmark_value(g,earth,1).
landmark_value(ng,nearth,-1).
landmark_value(ng,zero,0).

%%%%%%%%%%%%%%%%%%%%
%% Region and Rules
%%%%%%%%%%%%%%%%%%%%

%%% Landmark Rules
rule(gravity, gravity, const(g,land(earth))).
rule(gravity_1, gravity, const(ng,land(nearth))).
rule(derivs, derivs, deriv(x_dot,a)).
rule(derivs_1, derivs, deriv(x,x_dot)).
rule(derivs_2, derivs, deriv(angle_pole_dot,angle_pole_a)).
rule(derivs_3, derivs, deriv(angle_pole,angle_pole_dot)).
rule(left, left, sum(a,g,angle_pole_a)).
rule(centre, centre, mplus(a,angle_pole_a)).
rule(right, right, sum(a,ng,angle_pole_a)).
rule(fall_1, fall_1, qnull).
rule(fall_2, fall_2, qnull).

%%% Correspond
correspond_sum(left,land(zero),land(zero),land(zero)).
correspond_sum(left,land(zero),land(zero),land(zero)).
correspond(centre,land(zero),land(zero)).
correspond_sum(right,land(zero),land(zero),land(zero)).
correspond_sum(right,land(zero),land(zero),land(zero)).

%%% Preconditions
% Precondition gravity
precond(gravity, true).

% Precondition derivs
precond(derivs, true).

% Precondition left
precond(left, bound, angle_pole, e, zero, i, pi2).

% Precondition centre
precond(centre, equal, angle_pole, land(zero)).

% Precondition right
precond(right, bound, angle_pole, i, npi2, e, zero).

% Precondition fall_1
precond(fall_1, bound, angle_pole, e, limit, i, pi2).

% Precondition fall_2
precond(fall_2, bound, angle_pole, i, npi2, e, nlimit).


%%%%%%%%%%%%%%%%%%%%
% End of Database - ASP
%%%%%%%%%%%%%%%%%%%%

