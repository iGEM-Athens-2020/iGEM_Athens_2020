function [dy] = kinetic_cellulose_function(~,y)

%constnats
IPTG=0.05;

aBcsA = 0.0998;
abcsA = 0.0025;
aBcsB = 0.0998;
abcsB = 0.0025;
aBcsC = 0.0998;
abcsC = 0.0024;
aBcsD = 0.0509;
abcsD = 0.0021;
aCcpAx = 0.0999;
accpAx = 0.0012;
aCmcax = 0.1;
acmcax = 8.3521*10^-4;
aCS = 0.0998;
bBcsA = 0.5119;
bbcsA = 0.0052;
bBcsAB = 0.0544;
bBcsB = 0.8627;
bbcsB = 0.0059;
bBcsCcellulose = 0.277;
bBcsC = 0.6339;
bbcsC = 0.0044;
bBcsDcellulose = 0.277;
bBcsD = 0.0746;
bbcsD = 0.0036;
bCcpAxcellulose = 0.227;
bCcpAx = 0.9298;
bccpAx = 0.0042;
bCmcaxcellulose = 0.3303;
bCmcax = 0.9793;
bcmcax = 0.0049;
bCS = 0.133;
bCScellulose = 0.4464;
dmax = 1.9284*10^-6;
KBcsA = 17.7236;
KBcsB = 4.6;
KBcsCcellulose = 12.64;
KBcsDcellulose = 12.64;
KCcpAxcellulose = 12.64;
KCmcaxcellulose = 12.64;
KCScellulose = 12.64;
Kd = 4.359*10^-2;
KIPTG = 0.0065;
KGlu = 900.4375;
KGluPBC = 1885.47; 
mmaxPBC = 0.0061;%change this

YXtotaltoGlu=0.123;

%gene and enzyme expression
%cmcax
dy(1,1)= bcmcax*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.8/(1^0.8+(y(17)/KGlu)^0.8))-acmcax*y(1); 
%ccpAx
dy(2,1)= bccpAx*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.8/(1^0.8+(y(17)/KGlu)^0.8))-accpAx*y(2);
%bcsA
dy(3,1)= bbcsA*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.005/(1^0.005+(y(17)/KGlu)^0.005))-abcsA*y(3);
%bcsB
dy(4,1)= bbcsB*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.005/(1^0.005+(y(17)/KGlu)^0.005))-abcsB*y(4);
%bcsC
dy(5,1)= bbcsC*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.005/(1^0.005+(y(17)/KGlu)^0.005))-abcsC*y(5);
%bcsD
dy(6,1)= bbcsD*(IPTG^3/(IPTG^3+KIPTG^3))*(1^0.005/(1^0.005+(y(17)/KGlu)^0.005))-abcsD*y(6);
%Cmcax
dy(7,1)= bCmcax*y(1)-aCmcax*y(7);
%CcpAx
dy(8,1)= bCcpAx*y(2) - aCcpAx*y(8);
%BcsA
dy(9,1)= bBcsA*y(3) - aBcsA*y(9);
%BcsB
dy(10,1)= bBcsB*y(4) - aBcsB*y(10);
%BcsAB
dy(11,1)= bBcsAB*(y(9)/(KBcsA+y(9)))*(y(10)/(KBcsB+y(10)));
%CS
dy(12,1)= bCS*y(11) - aCS*y(12); 
%BcsC
dy(13,1)= bBcsC*y(5) - aBcsC*y(13);
%BcsD
dy(14,1)= bBcsD*y(6) - aBcsD*y(14);
%cellulose
dy(15,1)= ((bCScellulose*y(12))/(KCScellulose+y(12))* (bCmcaxcellulose*y(7))/(KCmcaxcellulose + y(7)) * (bCcpAxcellulose*y(8))/(KCcpAxcellulose+y(8)) * (bBcsCcellulose*y(13))/(KBcsCcellulose+y(13)) * (bBcsDcellulose*y(14))/(KBcsDcellulose+y(14)))*y(16);

%growth kinetics
%Xtotal
dy(16,1) = (mmaxPBC * y(16) * y(17))/(KGluPBC + y(17)) - (dmax/(Kd+y(17)) * y(16));
%Glucose
dy(17,1) = -(mmaxPBC*y(16)*y(17))/(YXtotaltoGlu*(KGluPBC+y(17)));

end

