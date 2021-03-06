function f = calcvel(i,j)
% Calculate incident velocity on any turbine

%% Initialise global variables
global windfarm
global alpha
global a
global U0
global Aj
global Dj

%% Wake model calculation
pwrcent = 0;
dwind = j;
dcord = windfarm(dwind,:);
for k = 1:1:numel(i)
    
    upwind = i(k);
    ucord = windfarm(upwind,:);
    xdistance = ucord(1)-dcord(1);
    Dwake = Dj + (2*alpha*abs(xdistance)); % Wake radius
    [xout,yout] = circcirc(dcord(2),dcord(1),Dj/2,ucord(2),ucord(1),Dwake/2);
    if isequalwithequalnans(xout, [NaN,NaN])==1 &&  isequalwithequalnans(yout, [NaN,NaN])==1
        Akj = Aj; % Complete overlap
    else
        rk = pi*Dwake^2/4;
        Ak = (rk^2*acos((xdistance^2+rk^2-Aj^2)/(2*xdistance*rk))+Aj^2*acos((xdistance^2+Aj^2-rk^2)/(2*xdistance*Aj))-0.5*sqrt((-xdistance+rk+Aj)*(xdistance-rk+Aj)*(xdistance+rk-Aj)*(xdistance+rk+Aj)));
        Akj= Ak; % Partial overlap
    end
    Ukj = U0*(1 - (2*a/(1+alpha*xdistance/27.87)^2));
    pwrcent = pwrcent+Akj*(U0-Ukj)^2/Aj;
end

%% Total wake energy loss
sigma = pwrcent;
f = U0 - sqrt(sigma);