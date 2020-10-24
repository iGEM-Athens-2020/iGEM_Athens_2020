function u = Janulevicius_ode(t,r,M,N,L,W,ub,ke,kr,TR)

% This function computes the velocities u of the set of bacteria. It can be
% used to solve the ODEs proposed by Janulevicius et al., as well as the
% extended version for Flavobacteria, as proposed by the iGEM Athens 2020
% team.
% 
%
% t: time variable
% r: spatial coordinates of each node
% M: number of bacteria
% N: number of nodes per bacterium
% L: length of the bacteria
% W: width of the bacteria (used for the collision detection algorithm)
% ub: experimental terminal velocity of the bacteria
% ke: engine constant (direction of the linear engine)
% kr: rotation constant (direction of the rotational engine) - if the
% bacteria do not rotate, use kr = 0
% TR: time values where the engine constant changes sign
% 
% 



% ----- Parameters ------
% You may edit them to change the elasticity of the bacteria and their
% collisions
kl = 1E-2; % (N*m), Linear springs constant
ka = 5E-16; % (N*m), Angular springs constant
kc = 6E-4; % (N*m), Collision constant
Femagn = 100E-12; % Force of engine (N)
torque = 1000E-21; % Torque of rotary engine (N*m)

l0 = L/(N-1);
zettat = (Femagn/N)/ub;
zettan = (1/2)*zettat;

% Global Variables:
nop = [];
l = [];
Fl = [];
Fa =[];
Fe = [];
Fr = [];
Fc = [];
n = [];
ti = [];
a = [];

% Reverse Engine
for bactnum = 1:M
    for numr = 2:2:length(TR(1,:))
        if ( t>TR(bactnum,numr) && t<TR(bactnum,numr+1) )
            ke(bactnum) = -ke(bactnum);
            break
        end
    end
end

r = reshape(r,M*N,2);
createnop();
Flinear(); % must be defined before unitvectors --> definition of l
unitvectors();
Fangular();
Fengine();
Frotation();
Fcollision();
velocities();



% Local to global numbering of nodes
    function createnop()
        for i = 1:N
            nop(1,i) = i;
        end
        
        if (M >= 2)
            for j = 2:M % Loop over bacteria
                for i = 1:N % Loop over nodes
                    nop(j,i) = nop(j-1,N) + i;
                end % Loop over nodes
            end % Loop over bacteria
        end
        
    end

% Definition of unit vectors t=ti (to avoid confusion with time variable), n
    function unitvectors()
        
        for j = 1:M % Loop over bacteria
            noptemp = nop(j,:);
            ketemp = ke(j);
            
            for i = 2:N-1 % Loop over nodes
                % Definition of ti
                ltemp = l(noptemp(i-1),:) + l(noptemp(i),:);
                ti(noptemp(i),:) = -ketemp * (ltemp)/norm(ltemp);
            end % Loop over nodes
            ti(noptemp(1),:) = -ketemp * l(noptemp(1),:)/norm(l(noptemp(1),:));
            ti(noptemp(N),:) = -ketemp * l(noptemp(N-1),:)/norm(l(noptemp(N-1),:));
            
            % Definition of n
            
            for i = 1:N % Loop over nodes
                theta = cart2pol(ti(noptemp(i),1),ti(noptemp(i),2));
                [n(noptemp(i),1),n(noptemp(i),2)] = pol2cart(theta + pi/2,1);
            end % Loop over nodes
            
        end % Loop over bacteria
        
    end

% Linear springs
    function Flinear()
        Fl = zeros(N*M,2); % Preallocation
        
        for j = 1:M % Loop over bacteria
            noptemp = nop(j,:);
            for i = 1:N-1 % Loop over nodes
                
                % Definition of l
                l(noptemp(i),:) = r(noptemp(i+1),:) - r(noptemp(i),:);
                
                % Definition of Fl
                li = norm(l(noptemp(i),:));
                Fl(noptemp(i),:) = Fl(noptemp(i),:) + -kl * (li - l0) * l(noptemp(i),:)/li;
                Fl(noptemp(i+1),:) = Fl(noptemp(i+1),:) - -kl * (li - l0) * l(noptemp(i),:)/li;
                
            end % Loop over nodes
            
        end % Loop over bacteria
        
    end

% Angular springs
    function Fangular()
        
        % Preallocation -----
        a = zeros(N*M,1);
        m = zeros(N*M,3);
        Fa = zeros(N*M,2);
        % -----------------
        
        for j = 1:M % Loop over bacteria
            noptemp = nop(j,:);
            for i = 1:N-2 % Loop over nodes
                li = l(noptemp(i),:);
                li1 = l(noptemp(i+1),:);
                
                a(noptemp(i)) = atan2(norm(cross([li 0],[li1 0])),dot([li 0],[li1 0]));
                
                
                m(noptemp(i),:) = cross([li, 0],[li1, 0]);
                
                % Definition of tau
                if (m(noptemp(i),3) == 0)
                    tautemp = zeros(1,3); % Avoid division by zero
                else
                    tautemp = ka*a(noptemp(i)) * m(noptemp(i),:)/norm(m(noptemp(i),:));
                end
                
                taui = tautemp;
                taui2 = -tautemp;
                
                
                % Definition of Fa
                Fai = cross([li,0],taui)/norm(li)^2; Fai = Fai(1:2);
                Fai2 = -cross([li1,0],taui2)/norm(li1)^2;Fai2 = Fai2(1:2);
                
                Fa(noptemp(i),:) = Fa(noptemp(i),:) + Fai;
                
                Fa(noptemp(i+2),:) = Fa(noptemp(i+2),:) + Fai2;
                
                Fa(noptemp(i+1),:) = Fa(noptemp(i+1),:) - (Fai + Fai2);
                
            end % Loop over nodes
            
        end % Loop over bacteria
        
    end

% Linear Engine
    function Fengine()
        % Preallocation -----
        Fe = zeros(M*N,2);
        % -----------------
        
        for j = 1:M % Loop over bacteria
            noptemp = nop(j,:);
            
            % Definition of Fe
            
            % Uniformely Distributed engine
            
            for i = 1:N % Loop over nodes
                Fe(noptemp(i),:) = (Femagn/N).*ti(noptemp(i),:);
            end % Loop over nodes
            
        end % Loop over bacteria
        
    end

% Rotational Engine (! Only for Flavobacteria !)
    function Frotation()
        
        % Preallocation ---------
        ri0 = zeros(M*N,2);
        ri0u = zeros(M*N,2);
        magnri0 = zeros(M*N,1);
        sinth = zeros(M*N,1);
        % ---------------------
        
        % If kr == 0, the rotational Forces are absent
        if (kr == 0)
            Fr = zeros(M*N,2);
            
        else
            
            for j = 1:M % Loop over bacteria
                noptemp = nop(j,:);
                krtemp = kr(j);
                
                for i = 2:N % Loop over nodes (note --> axis of rotation always N = 1)
                    ri0(i,:) = r(noptemp(i),:) - r(noptemp(1),:);
                    ri0u(i,:) = ri0(i,:)/norm(ri0(i,:));
                    magnri0(i) = norm(ri0(i,:));
                    sinth(i) = norm(cross(krtemp*[n(noptemp(i),:) 0] , ...
                        [ri0u(i,:) 0]));
                end
                
                const = torque/sum(magnri0.^2);
                
                for i = 2:N % Loop over nodes
                    Frmagn = const*magnri0(i)/sinth(i);
                    Fr(noptemp(i),:) = Frmagn*krtemp*n(noptemp(i),:);
                end  % Loop over nodes
                
            end % Loop over bacteria
            
        end
        
    end

% Collisions
    function Fcollision()
        
        % Preallocation -----
        Fc = zeros(N*M,2);
        % -----------------
        
        for j = 1:M % Loop over bacteria ij
            noptempj = nop(j,:);
            
            for i = 1:N-1 % Loop over nodes ij
                rij = r(noptempj(i),:);
                ri1j = r(noptempj(i+1),:);
                
                if i <= N-3 % Same bacterium
                    el = j;
                    noptempl = nop(el,:);
                    
                    for k = i+2:N-1 % Loop over nodes kl (same bacterium)
                        rkl = r(noptempl(k),:);
                        rk1l = r(noptempl(k+1),:);
                        
                        % Collision Detection
                        [P1,P2,~] = colllinsolv(rij, ri1j, rkl, rk1l);
                        
                        Qij = rij + P1*(ri1j - rij);
                        Qkl = rkl + P2*(rk1l - rkl);
                        d = Qij - Qkl;
                        dm = norm(d);
                        
                        % Collision Resolution
                        if dm <= W
                            
                            Fc(noptempj(i),:) = Fc(noptempj(i),:) - ...
                                (1-P1)*(kc*(dm-W)*(d/dm));
                            Fc(noptempj(i+1),:) = Fc(noptempj(i+1),:) - ...
                                P1*(kc*(dm-W)*(d/dm));
                            Fc(noptempl(k),:) = Fc(noptempl(k),:) + ...
                                (1-P2)*(kc*(dm-W)*(d/dm));
                            Fc(noptempl(k+1),:) = Fc(noptempl(k+1),:) + ...
                                P2*(kc*(dm-W)*(d/dm));
                        end
                        
                    end % Loop over nodes kl (same bacterium)
                    
                end
                
                % Other bacteria
                if j<M
                    
                    for el = j+1:M % Loop over bacteria kl (usage of el to 
                        % avoid confusion with l)
                        
                        noptempl = nop(el,:);
                        
                        for k = 1:N-1 % Loop over nodes kl
                            
                            rkl = r(noptempl(k),:);
                            rk1l = r(noptempl(k+1),:);
                            
                            % Collision Detection
                            [P1,P2,~] = colllinsolv(rij, ri1j, rkl, rk1l);
                            
                            Qij = rij + P1*(ri1j - rij);
                            Qkl = rkl + P2*(rk1l - rkl);
                            d = Qij - Qkl;
                            dm = norm(d);
                            
                            % Collision Resolution
                            if dm <= W
                                    
                                Fc(noptempj(i),:) = Fc(noptempj(i),:) - ...
                                    (1-P1)*(kc*(dm-W)*(d/dm));
                                Fc(noptempj(i+1),:) = Fc(noptempj(i+1),:) - ...
                                    P1*(kc*(dm-W)*(d/dm));
                                Fc(noptempl(k),:) = Fc(noptempl(k),:) + ...
                                    (1-P2)*(kc*(dm-W)*(d/dm));
                                Fc(noptempl(k+1),:) = Fc(noptempl(k+1),:) + ...
                                    P2*(kc*(dm-W)*(d/dm));
                                
                            end
                            
                        end % Loop over nodes kl
                        
                    end % Loop over bacteria kl
                    
                end % if loop
                
            end % Loop over nodes ij
            
            % Limit of excessive bending of angular springs
            
            for i = 1:N-2
                rij = r(noptempj(i),:);
                ri2j = r(noptempj(i+2),:);
                d = rij - ri2j;
                dm = norm(d);
                
                if (dm <= W)
                    Fc(noptempj(i),:) = Fc(noptempj(i),:) - ...
                        kc*(dm-W)*(d/dm);
                    Fc(noptempj(i+2),:) = Fc(noptempj(i+2),:) + ...
                        kc*(dm-W)*(d/dm);
                end
                
            end % Loop over nodes ij
            
        end % Loop over bacteria ij
        
    end

% Collision Detection Function
% Copyrights of algorithm: "Real-Time Collision Detection"
% by C. Ericson, Elsevier B.V. 2005 - slightly changed
    function [P1,P2,d] = colllinsolv(rij, ri1j, rkl, rk1l)
        
        dij = ri1j - rij; % Direction vector of segment Qij
        dkl = rk1l - rkl; % Direction vector of segment Qkl
        rr = rij - rkl;
        alph = dot(dij,dij); % Squared length of segment Qij, always nonnegative
        e = dot(dkl,dkl); % Squared length of segment Qkl, always nonnegative
        f = dot(dkl,rr);
        
        % Check if either or both segments degenerate into points
        EPSILON = 1E-16; % PRONE TO CHANGE (but probably not needed)
        if (alph <= EPSILON && e <= EPSILON)
            % Both segments degenerate into points
            %             s = 0; tt = 0;
            c1 = rij;
            c2 = rkl;
            d = dot(c1 - c2, c1 - c2);
            P1 = 0; P2 = 0;
            return
        else
            if (alph <= EPSILON)
                % First segment degenerates into a point
                s = 0;
                tt = f/e; % s=0=>tt=(b*s+f)/e=f/e
                tt = min(max(tt, 0),1);
            else
                c = dot(dij, rr);
                if (e <= EPSILON)
                    % Second segment degenerates into a point
                    tt = 0;
                    s = min(max(-c/alph, 0), 1); % tt=0=>s=(b*tt-c)/a=-c/a
                else
                    % The general nondegenerate case starts here
                    b = dot(dij, dkl);
                    denom = alph*e-b*b; % Always nonnegative
                    % If segments not parallel, compute closest point on L1 to L2 and
                    % clamp to segment S1. Else pick arbitrary s (here 0)
                    if (denom ~= 0)
                        s = min(max((b*f - c*e)/denom, 0), 1);
                    else
                        s = 0;
                    end
                    % Compute point on L2 closest to S1(s) using
                    % tt = Dot((P1 + D1*s) - P2,D2) / Dot(D2,D2) = (b*s + f) / e
                    tt = (b*s+f)/e;
                    % If tt in [0,1] done. Else clamp tt, recompute s for the new value
                    % of tt using s = Dot((P2 + D2*tt) - P1,D1) / Dot(D1,D1)= (tt*b - c) / alph
                    % and clamp s to [0, 1]
                    if (tt < 0)
                        tt = 0;
                        s = min(max(-c/alph, 0), 1);
                    elseif (tt > 1)
                        tt = 1;
                        s = min(max((b - c)/alph, 0), 1);
                    end
                end
            end
            
            c1=rij+dij*s;
            c2=rij+dkl*tt;
            P1 = s;
            P2 = tt;
            d = sqrt(dot(c1 - c2, c1 - c2));
            
        end
        
    end

% Velocities of nodes
    function velocities()
        
        % Sum of Forces
        F = Fl + Fa + Fc + Fr + Fe;
        
        % Velocity components
        % Preallocation ------
        ut = zeros(N*M,2);
        un = zeros(N*M,2);
        % ------------------
        
        for j = 1:M % Loop over bacteria
            noptemp = nop(j,:);
            
            for i = 1:N % Loop over nodes
                ut(noptemp(i),:) = (1/zettat)*(dot(ti(noptemp(i),:),F(noptemp(i),:)))*ti(noptemp(i),:);
                un(noptemp(i),:) = (1/zettan)*(dot(n(noptemp(i),:),F(noptemp(i),:)))*n(noptemp(i),:);
            end % Loop over nodes
            
        end % Loop over bacteria
        
        % Sum of velocity components
        u = ut + un;
        u = u(:);
        
    end



end