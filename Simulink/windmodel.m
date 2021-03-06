function tauw = windmodel(gamma,Vr)
L = 20/100;
B = 20/100;
h = 4/100;
AT = h*L*cos(gamma);
AL = h*B*sin(gamma);
ASS = pi*(10/100)^2;
S = 2*(cos(gamma)*B+h);
C = sqrt((L*cos(gamma)-B*sin(gamma))^2+(L*cos(gamma)+B*sin(gamma))^2);
M = 1;


de = [0:10:180];
con = [2.152,-5.00,0.243,-0.164,0,0,0;1.714,-3.33,0.145,-0.121,0,0,0;1.818,-3.97,0.211,-0.143,0,0,0.033;1.965,-4.81,0.243,-0.154,0,0,0.041;2.333,-5.99,0.247,-0.19,0,0,0.042;
    1.726,-6.54,0.189,-0.173,0.348,0,0.048;0.913,-4.68,0,-0.104,0.482,0,0.052;0.457,-2.88,0,-0.068,0.346,0,0.043;0.341,-0.91,0,-0.031,0,0,0.032;0.355,0,0,0,-0.247,0,0.018;
    0.601,0,0,0,-0.372,0,-0.020;0.651,1.29,0,0,-0.582,0,-0.031;0.564,2.54,0,0,-0.748,0,-0.024;-0.142,3.58,0,0.047,-0.7,0,-0.028;-0.677,3.64,0,0.069,-0.529,0,-0.032;
    -0.723,3.14,0,0.064,-0.475,0,-0.032;-2.148,2.56,0,0.081,0,1.27,-0.027;-2.707,3.97,-0.175,0.126,0,1.81,0;-2.529,3.76,-0.174,0.128,0,1.55,0];
windsurge=[ transpose(de),con];

con1 = [zeros(1,7);0.096,0.220,0,0,0,0,0;0.176,0.71,0,0,0,0,0;0.225,1.38,0,0.023,0,-0.29,0;0.329,1.82,0,0.043,0,-0.59,0;1.164,1.26,0.121,0,-0.242,-0.95,0;
    1.163,0.96,0.101,0,-0.177,-0.88,0;0.916,0.53,0.069,0,0,-0.65,0;0.844,0.55,0.082,0,0,-0.54,0;0.889,0,0.138,0,0,-0.66,0;0.799,0,0.155,0,0,-0.55,0;
    0.797,0,0.151,0,0,-0.55,0;0.996,0,0.184,0,-0.212,-0.66,0.34;1.014,0,0.191,0,-0.28,-0.69,0.44;0.784,0,0.166,0,-0.209,-0.53,0.38;0.536,0,0.176,-0.029,-0.163,0,0.27;
    0.251,0,0.106,-0.022,0,0,0;0.125,0,0.046,-0.012,0,0,0;zeros(1,7)];
windsway=[transpose(de),con1];


con2 = [zeros(1,6);0.0596,0.061,0,0,0,-0.074;0.1106,0.204,0,0,0,-0.17;0.2258,0.245,0,0,0,-0.38;0.2017,0.457,0,0.0067,0,-0.472;0.1759,0.573,0,0.0118,0,-0.523;
    0.1925,0.48,0,0.0115,0,-0.546;0.2133,0.315,0,0.0081,0,-0.526;0.1827,0.254,0,0.0053,0,-0.443;0.2627,0,0,0,0,-0.508;0.2102,0,-0.0195,0,0.0335,-0.492;
    0.1567,0,-0.0258,0,0.0497,-0.457;0.0801,0,-0.0311,0,0.0740,-0.396;-0.0189,0,-0.0488,0.0101,0.1128,-0.42;0.0256,0,-0.0422,0.0100,0.0889,-0.463;
    0.0552,0,-0.0381,0.0109,0.0689,-0.476;0.0881,0,-0.0306,0.0091,0.0366,-0.415;0.0851,0,-0.0122,0.0025,0,-0.22;zeros(1,6)];
windyaw = [transpose(de),con2];

gamma = rad2pipi(gamma);
gamma = rad2deg(gamma);

i = floor(abs(gamma)/10)+1;
A0 = windsurge(i,2);
A1 = windsurge(i,3);
A2 = windsurge(i,4);
A3 = windsurge(i,5);
A4 = windsurge(i,6);
A5 = windsurge(i,7);
A6 = windsurge(i,8);
B0 = windsway(i,2);
B1 = windsway(i,3);
B2 = windsway(i,4);
B3 = windsway(i,5);
B4 = windsway(i,6);
B5 = windsway(i,7);
B6 = windsway(i,8);
C0 = windyaw(i,2);
C1 = windyaw(i,3);
C2 = windyaw(i,4);
C3 = windyaw(i,5);
C4 = windyaw(i,6);
C5 = windyaw(i,7);

Cx = A0+((A1*2*AL)/L^2)+((A2*2*AT)/(B^2))+(A3*L)/B + (A4*S)/L + (A5*C)/L + A6*M;
Cy = B0+((B1*2*AL)/L^2)+((B2*2*AT)/(B^2))+(B3*L)/B + (B4*S)/L + (B5*C)/L + (B6*ASS)/M;
Cn = C0+((C1*2*AL)/L^2)+((C2*2*AT)/(B^2))+(C3*L)/B + (C4*S)/L + (C5*C)/L;

Xw = (Cx*1.225*Vr^2*AT)/2;
Yw = (Cy*1.225*Vr^2*AL)/2;
Nw = (Cn*1.225*Vr^2*AL*L)/2;

tauw = [Xw;Yw;Nw]*sign(gamma);
end












