clear;
clc;

R1 = 1;
Cp = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
a = 100;
R4 = 0.1;
R0 = 1000;

G = zeros(7);
C = zeros(7);

G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;
G0 = 1/R0;

G(1,:) = [-G1 G1 0 0 0 0 -1];
G(2,:) = [-G1 G1+G2 0 0 1 0 0];
G(3,:) = [0 0 -G3 0 1 0 0];
G(4,:) = [0 0 0 0 -a/(R4+R0) 1 0];
G(5,:) = [0 0 0 G0 0 -1 0];
G(6,:) = [1 0 0 0 0 0 0];
G(7,:) = [0 -1 1 0 0 0 0];


C(1,1) = -Cp;
C(1,2) = Cp;
C(2,1) = -Cp;
C(2,2) = Cp;
C(7,6) = L;

V1 = [];
V0 = [];
V3 = [];

for i=-10:10
    F = [0;0;0;0;0;i;0];
    V = G\F;
     V1 = [V1;V(1)];
     V0 = [V0;V(4)];
     V3 = [V3;V(3)];     
end

x = linspace(-10,10,21);
figure(1)
plot(x,V0)
hold on
plot(x,V3)

V1 = [];
V0 = [];
V3 = [];

freq = 1000;

for w = 0:freq
    F = [0;0;0;0;0;10;0];
    V = (G+(j*w)*C)\F;
    V0 = [V0;V(4)];
    V1 = [V1;V(1)];
    V3 = [V3;V(3)];
end

x = linspace(0,freq,freq+1);
figure(2)
semilogx(x,real(V0))
hold on
semilogx(x,real(V0./V1),'k')


V1 = [];
V0 = [];
V3 = [];
W = [];

for i = 0:freq
    w = normrnd(pi,.05);
    F = [0;0;0;0;0;10;0];
    V = (G+(j*w)*C)\F;
    W = [W;V(4)/V(1)];
    
end

x = linspace(0,freq,freq+1);
figure(3)
histogram(real(W));










