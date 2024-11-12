x = zeros(1,1000);
x(1) = 10;
poles = [];
y = x;
n = 4;
xx = zeros(n,1000);


for j = 1:n

    k = 1;
    %l = rand;
    %IE = rand;
    M = k;
    M = M + rand*0.3;
    b = sqrt(4*k*M)-2*rand;
    
    A = [0 1;-k/M -b/M];
    B = [0;1/M];
    C = [1 0];
    D = 0;
    
    sys1 = ss(A,B,C,D,0.01);
    sys2 = idtf(sys1);
    y = sim(sys2,y.');
    y = y.';
    for l = 1:j
        xx(l,:) = xx(l,:)+y;
    end
    
    
    poles = [poles (-b+sqrt(b^2-4*k*M))./(2*M) (-b-sqrt(b^2-4*k*M))./(2*M)];

end

TF = fftshift(conj(fft(y)))./fftshift(conj(fft(x)));

fi = linspace(-pi,pi,1001);
fi(end) = [];
ff = exp(1i.*fi);

plot(real(ff),imag(ff))
axis equal
axis square
hold on
plot(real(poles),imag(poles),"ro")
figure
plot(y)
figure
plot(abs(fftshift(conj(fft(y)))./fftshift(conj(fft(x)))))