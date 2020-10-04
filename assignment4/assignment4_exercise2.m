m=256;
t=linspace(0,1,m)';
y=exp(-128*((t-0.3).^2))-3*(abs(t-0.7).^0.4);

mpdict=wmpdictionary(m,'LstCpt',{'dct',{'wpsym4',2}});
A=full(mpdict);

%% (a) 
% l1-norm
N = size (A,2);
one = ones(1,N);
cvx_begin 
    variable x(N)
    minimize (norm(x,1))
    subject to
    A*x==y;
cvx_end
x1 = x;
error_l1 = norm(A*x1 - y, 2)^2/norm(y, 2)^2;
% l2-norm
clear x;
N = size(A,2);
one = ones(1,N);
cvx_begin 
    variable x(N)
    minimize (norm(x,2))
    subject to
    A*x==y;
cvx_end
x2 = x;
error_l2 = norm(A*x2 - y, 2)^2/norm(y, 2)^2;
%%  (b)
fprintf('error for l1 norm:%d \n', error_l1)
fprintf('error for l2 norm:%d \n', error_l2)
%%  (c)
n = ceil(length(x)*0.05);
x1_5 = zeros(length(x), 1);
x2_5 = zeros(length(x), 1);
temp1 = x1;
temp2 = x2;
for i = 1:n
    [val, pose] = max(abs(temp1));
    x1_5(pose) = temp1(pose);
    temp1(pose) = 0;
    [val, pose] = max(abs(temp2));
    x2_5(pose) = temp2(pose);
    temp2(pose) = 0;
end
error_l1_5 = norm(A*x1_5-y,2)^2/norm(y,2)^2;
error_l2_5 =norm(A*x2_5-y,2)^2/norm(y,2)^2;

fprintf('error for l1 norm with 5 percent of data:%d \n', error_l1_5)
fprintf('error for l2 norm with 5 percent of data:%d \n', error_l2_5)

figure(1)
hold all;
plot(A*x1_5,'LineWidth', 5);
plot(A*x2_5,'LineWidth', 5)
plot(y,'LineWidth', 3)
ylabel('$Ax$', 'Interpreter','latex')
xlabel('')
legend({'$Ax_1$','$Ax_2$','$y$'}, 'Interpreter','latex')
set(gca)
%%  (d)
n = ceil(length(x)*0.03);
x1_3 = zeros(length(x), 1);
x2_3 = zeros(length(x), 1);
temp1 = x1;
temp2 = x2;
for i = 1:n
    [~, pose] = max(abs(temp1));
    x1_3(pose) = temp1(pose);
    temp1(pose) = 0;
    [val, pose] = max(abs(temp2));
    x2_3(pose) = temp2(pose);
    temp2(pose) = 0;
end
error_l1_3 = norm(A*x1_3-y,2)^2/norm(y,2)^2;
error_l2_3 =norm(A*x2_3-y,2)^2/norm(y,2)^2;

fprintf('error for l1 norm with 3 percent of data:%d \n', error_l1_3)
fprintf('error for l2 norm with 3 percent of data:%d \n', error_l2_3)

figure(2)
hold all;
plot(A*x1_3,'LineWidth', 5);
plot(A*x2_3,'LineWidth', 5)
plot(y,'LineWidth', 3)
ylabel('$Ax$', 'Interpreter','latex')
xlabel('')
legend({'$Ax_1$','$Ax_2$','$y$'}, 'Interpreter','latex')
set(gca)
% 
%%
n = ceil(length(x)*0.01);
x1_1 = zeros(length(x), 1);
x2_1 = zeros(length(x), 1);
temp1 = x1;
temp2 = x2;
for i = 1:n
    [~, pose] = max(abs(temp1));
    x1_1(pose) = temp1(pose);
    temp1(pose) = 0;
    [val, pose] = max(abs(temp2));
    x2_1(pose) = temp2(pose);
    temp2(pose) = 0;
end
error_l1_1 = norm(A*x1_1-y,2)^2/norm(y,2)^2;
error_l2_1 =norm(A*x2_1-y,2)^2/norm(y,2)^2;

fprintf('error for l1 norm with 1 percent of data:%d \n', error_l1_1)
fprintf('error for l2 norm with 1 percent of data:%d \n', error_l2_1)

figure(3)
hold all;
plot(A*x1_1,'LineWidth', 5);
plot(A*x2_1,'LineWidth', 5)
plot(y,'LineWidth', 3)
ylabel('$Ax$', 'Interpreter','latex')
xlabel('')
legend({'$Ax_1$','$Ax_2$','$y$'}, 'Interpreter','latex')
set(gca)