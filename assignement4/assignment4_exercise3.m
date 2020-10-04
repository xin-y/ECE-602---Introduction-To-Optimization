%% input data
A_bar = [ 60 45 -8; ...
90 30 -30; ...
0 -8 -4; ...
30 10 -10];
d = .05;
R = d*ones(4,3);
b = [ -6; -3; 18; -9];
%%
% least-squares solution
x_ls = A_bar\b;
% robust least-squares solution
cvx_begin
    variables x(3) y(4) z(3)
    minimize ( norm( y ) )
    A_bar*x + R*z - b <= y
    A_bar*x - R*z - b >= -y
    x <= z;
    x + z >= 0
cvx_end
%%
% computing nominal residual norms
nom_res_ls = norm(A_bar*x_ls - b);
nom_res_rls = norm(A_bar*x - b);
% computing worst-case nominal norms
r = A_bar*x_ls - b;
Delta = zeros(4,3);
for i=1:length(r)
if r(i) < 0
Delta(i,:) = -d*sign(x_ls');
else
Delta(i,:) = d*sign(x_ls');
end
end
wc_res_ls = norm(r + Delta*x_ls);
wc_res_rls = cvx_optval;
% display
disp(nom_res_ls);
disp(nom_res_rls);
disp(wc_res_ls);
disp(wc_res_rls);