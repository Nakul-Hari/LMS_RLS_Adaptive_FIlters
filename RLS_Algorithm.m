N = 100;
M = 4;
lambda = 0.95; 

n = (0:N-1)';
x = 1 + sin(n * pi / 2);

h = [0.5 0.5 0.5 0.5]; 
d = filter(h, 1, x);

w = zeros(M, 1); 
P = eye(M) * 7.5; % Inverse of the correlation matrix || Initialization

e = zeros(N, 1); % Error signal
y = zeros(N, 1); % Filter output


%% RLS Algorithm

for n = M:N
    x_n = x(n:-1:n-M+1);
    y(n) = w' * x_n;
    e(n) = d(n) - y(n);
    k = (P * x_n) / (lambda + x_n' * P * x_n);
    P = (P - k * x_n' * P) / lambda
    w = w + k * e(n);
end



%% Display Final Filter Coefficients

disp('Final filter coefficients:');
disp(w);

%% Plotting Error vs Iteration

plot(e);
title('Error Signal for RLS');
xlabel('Sample');
ylabel('Error');
