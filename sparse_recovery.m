% sparse signal recovery using L1

rng(0);

N = 256;
f = @(x) .5*sin(3*x).*cos(.1*x)+sin(1.3*x).*sin(x)-.7*sin(.5*x).*cos(2.3*x).*cos(x);
x = linspace(-10*pi, 10*pi, N);
y = f(x);

subplot(3,2,1);
coef = dct(y)';
stem(coef);
xlim([0 N]);
title('Original signal in frequency domain');

subplot(3,2,2);
plot(x,y);
title('Original signal in time domain');
xlim([min(x) max(x)]);

% measurement matrix
K=80;
A=randn(K, N);
A=orth(A')';

% observations
b=A*coef;

% min-energy observations
c0 = A'*b;
subplot(3,2,3);
stem(c0);
xlim([0 N]);
title('Minimum energy recovery - coef');

subplot(3,2,4);
y0 = idct(c0, N);
plot(1:N, y0,'r', 1:N, y, 'b');
xlim([0 N]);
title('Minimum energy recovery - signal');
legend('Recovered', 'Original');

% L1-minimization
[c1, fitinfo] = lasso(A, b, 'Lambda', 0.01);
subplot(3,2,5);
stem(c1);
xlim([0 N]);
title('L1 recovery - coef');

subplot(3,2,6);
y1 = idct(c1, N);
plot(1:N, y1, 'r', 1:N, y, 'b');
xlim([0 N]);
title('L1 recovery - signal');
legend('Recovered', 'Original');
