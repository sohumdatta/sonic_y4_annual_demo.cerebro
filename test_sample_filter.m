% test_sample_filter.m: test sample_filter.m

lb = randi([2 20]);
la = randi([2 20]);

% randomly assign coefficients
f_0 = 40 + rand*40;  %US Power supply freq is 60 Hz, but Simone used 50Hz
Q = rand*80 + 10;
fs = 1000*rand + 100; %1KHz
wo = f_0/(fs/2);  
bw = wo/Q;
[b,a] = iirnotch (wo,bw);

if(a(1) == 0) 
	a(1) = rand; %guaranteed not zero
end
% 10 intervals, each of length atleast 2* max(a,b)
L = max(length(a), length(b));
intr_len = randi([L, 100], [1 10]);

% setup data
x = randn(1, sum(intr_len));
y = filter(b, a, x);

ynew = []; xp = []; yp = [];
start = 1;
for len = intr_len
	xnow = x(start: len + start - 1);
	ynow = sample_filter(b, a, xnow, xp, yp);
	ynew = [ynew, ynow];
	xp = xnow; yp = ynow;
	start = start + len;
end

tol = 1e-10;	% a very small constant for floating point comparison

if(all(abs(y - ynew) <= tol))  
	disp('PASSED simple test: sample_filter');
else 
	disp('FAILED simple test: sample_filter');
end
