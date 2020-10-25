clear; clc; close

% Limits of Each Axis - Please customize
xl = -0.5E-5;
xu = 4E-5;
yl = -1.5E-5;
yu = 3E-5;
% ------

M = 2; % Number of bacteria
N = 8; % Number of particles per bacterium


% % --- M. xanthus - Parameters for the original Janulevicius model ---
% L = 5E-6; % Length of bacterium (m)
% W = 0.5E-6; % Width of bacterium (m)
% ub = 4 * 10^-6/60; % Experimental Terminal Velocity (m/s)
% tend = 300; % Maximum time (s)
% kr = 0; % No rotational engine
% TRav = 8.8*60; % Average reversal time (s)
% TRstd  = 2.1*60; % ﻿Standard deviation of reversal time (s)
% % -----------------

% --- ﻿F. johnsoniae Parameters for the customized model used for the
% competition ---
L = 3.38E-6; %  % Length of bacterium (m)
W = 0.295E-6; % Width of bacterium (m)
ub = 3E-6; % Experimental Terminal Velocity (m/s)
tend = 12; % Maximum time (s)
kr = binornd(1,0.97,M,1); % Rotational engine direction
for kecount=1:M
    if (kr(kecount) == 0)
        kr(kecount) = -1;
    end
end
kr = 0;
TRav = 8.8*60; % Average reversal time (s)
TRstd  = 2.1*60; % ﻿Standard deviation of reversal time (s)
% -----------------

% Time values when the bacterium changes its direction
trev = inf*ones(M,1);
for bactnum = 1:M
    TR(bactnum,1) = normrnd(TRav,TRstd);
end
timerev = 0;
while sum( (TR(:,timerev + 1) <= tend) ) ~= 0
    timerev = timerev + 1;
    TR = [TR, zeros(M,1)];
    for bactnum = 1:M
        if (TR(bactnum,timerev) <= tend)
            timerev; 
            TR(bactnum,timerev);
            TR(bactnum,timerev+1) = TR(bactnum,timerev) + normrnd(TRav,TRstd);
        else
            TR(bactnum,timerev+1) = inf;
        end
    end
end
if ( rem(length(TR(1,:)),2) == 0 )
    TR = [TR, inf*ones(M,1)];
end
    

% Initial configuration
% The initial configuration of the bacteria has to been given as input.
% It has to be given as a table 2X(N*M) in an ordered manner.
% We encourage the user to make a custom configuration. However, in the
% following line is the function that we used (and sometimes altered) to
% produce the initial configuration of the bacteria.
[rin,ke] = Initial_conf(M,N,L,3);
% --------------------------------

rinplot = reshape(rin,M*N,2);
xinplot = zeros(N,M);
yinplot = zeros(N,M);
for j = 1:M
    for i = 1:N
        xinplot(i,j) = rinplot((j-1)*N+i,1);
        yinplot(i,j) = rinplot((j-1)*N+i,2);
    end
end

figure(1)
plot(xinplot, yinplot,'-ks','LineWidth',10)
set(gca,'DataAspectRatio',[1,1,1])
title('Initial Condition')
xlabel('x (m)')
ylabel('y (m)')
xlim([xl xu]);
ylim([yl yu]);

input('Please examine the initial condition as shown in Figure 1. Press Enter to continue')

% The following line is the actual simulation
[TOUT,ROUT] = ode15s(@(t,r) ...
    iGEM_Athens_2020_Simulation(t,r,M,N,L,W,ub,ke,kr,TR), [0,tend], rin);


XOUT = ROUT(:,1:M*N);
YOUT = ROUT(:,M*N+1:2*M*N);

input('The simulation has been sucessfully completed. Press Enter to continue')
close
% PLOT
for t = 1:length(TOUT)
    for j = 1:M
        for i = 1:N
            x(i,j,t) = XOUT(t,(j-1)*N+i);
            y(i,j,t) = YOUT(t,(j-1)*N+i);
        end
    end
    figure(1)
    plot(x(:,:,t), y(:,:,t),'-ks','LineWidth',10);
    set(gca,'DataAspectRatio',[1,1,1])
    xlabel('x (m)')
    ylabel('y (m)')
    title(['t = ' num2str(TOUT(t)) ' s'])
    xlim([xl xu]);
    ylim([yl yu]);
    hold off
    if (t == 1)
        pause(1/60*(TOUT(t)))
    else
        pause(1/60*(TOUT(t)-TOUT(t-1)))
    end
end