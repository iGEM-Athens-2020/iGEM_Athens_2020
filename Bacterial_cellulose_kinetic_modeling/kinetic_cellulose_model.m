clear,clc

%initial values (in mg/L)
y0=[1*10^-10,1*10^-10,1*10^-10,1*10^-10,1*10^-10,1*10^-10,1,1,1,1,1,1,1,1,0,400,4000];

%time period (in minutes)
t0=0;
tmax=600;
dt=1;
tspan=t0:dt:tmax;

%solve the ODEs
[t_sol,y_sol]=ode45(@kinetic_cellulose_function,tspan,y0);

%plot the results
% figure(1)
% plot(t_sol,y_sol(:,15))
% legend("cellulose")
% xlim([0 1000])
% movegui("east")
% 
% %plot the results
% figure(2)
% plot(t_sol,y_sol(:,16))
% legend("Biomass")
% xlim([0 1000])
% movegui("west")
% 
% %plot the results
% figure(3)
% plot(t_sol,y_sol(:,17))
% legend("Glucose")
% xlim([0 1000])
% movegui("center")

%another way of presenting the results
figure(1)
subplot(2,2,[3 4])
plot(t_sol,y_sol(:,15))
ylabel("Cellulose mg/L")
subplot(2,2,1)
plot(t_sol,y_sol(:,16))

ylabel("Biomass mg/L")
subplot(2,2,2)
plot(t_sol,y_sol(:,17))
ylabel("Glucose mg/L")


