%
% ASP implementation of QSIM
% Author: Timothy Wiley, UNSW Australia
%
%
% ball_db Database
%

%%% QVars
qvar(y).
qvar(v).
qvar(a).

%%% Discrete

%%% landmarks
landmark(y,minf).
landmark(y,zero).
landmark(y,inf).
landmark(v,minf).
landmark(v,zero).
landmark(v,vv).
landmark(v,inf).
landmark(a,minf).
landmark(a,aa).
landmark(a,zero).

%%% adjacent_landmark
adjacent_landmark(y,minf,zero).
adjacent_landmark(y,zero,inf).
adjacent_landmark(v,minf,zero).
adjacent_landmark(v,zero,vv).
adjacent_landmark(v,vv,inf).
adjacent_landmark(a,minf,aa).
adjacent_landmark(a,aa,zero).

%%%%%%%%%%%%%%%%%%%%
%% Region and Rules
%%%%%%%%%%%%%%%%%%%%

%%% Landmark Rules
rule(ball, ball, deriv(y,v)).
rule(ball_1, ball, deriv(v,a)).

%%% Correspond

%%% Preconditions
% Precondition ball
precond(ball, true).


%%%%%%%%%%%%%%%%%%%%
% End of Database - ASP
%%%%%%%%%%%%%%%%%%%%

