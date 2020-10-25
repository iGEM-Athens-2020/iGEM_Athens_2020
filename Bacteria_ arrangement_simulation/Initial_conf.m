function [r,ke] = Initial_conf(M,N,L,n)
xtemp = zeros(N,M); % (m)
ytemp = zeros(N,M); % (m)

if (n == 1)
    % Coordinate Arrays (default --> Random and Pararel)
    % WARNING overlap may occur!
    
    for j = 1:M
        slope = unifrnd(-100,100);
        xtemp(1,j) = unifrnd(-2E-5,2*10^-5);
        ytemp(1,j) = unifrnd(-2E-5,2*10^-5);
        
        for i = 2:N
            xtemp(i,j) = xtemp(i-1,j) + (L/(N-1))*cos(slope); % meters
            ytemp(i,j) = ytemp(i-1,j) + (L/(N-1))*sin(slope); % meters
        end
    end
    
    ke = binornd(1,0.5,M,1); % Κατεύθυνση του κινητήρα - 1/2 πιθανότητα
    for kecount=1:M
        if (ke(kecount) == 0)
            ke(kecount) = -1;
        end
    end
    
end

if (n == 2)
    % Parallel and adjacent
    % WARNING: if the bacteria are rigid, movement may not occur
    
    slope = 0;
    
    xtemp(1,1) = 0;
    ytemp(1,1) = 0;
    
    for i = 2:N
        xtemp(i,1) = xtemp(i-1,1) + (L/(N-1))*cos(slope); % meters
        ytemp(i,1) = ytemp(i-1,1) + (L/(N-1))*sin(slope); % meters
    end
    
    deka = 1;
    
    for j = 2:M
        deka = deka +1;
        
        xtemp(1,j) = xtemp(N,j-1) + (L/(N-1));
        ytemp(1,j) = ytemp(N,j-1);
        
        if deka == 7
            xtemp(1,j) = xtemp(1,j-deka+1);
            ytemp(1,j) = ytemp(1,j-deka+1) + (L/(N-1));
            deka = 1;
        end
        
        for i = 2:N
            xtemp(i,j) = xtemp(i-1,j) + (L/(N-1))*cos(slope); % meters
            ytemp(i,j) = ytemp(i-1,j) + (L/(N-1))*sin(slope); % meters
        end
        
        
    end
    
    ke = binornd(1,0.5,M,1); % Normal ditribution
    for kecount=1:M
        if (ke(kecount) == 0)
            ke(kecount) = -1;
        end
    end
    
end

if (n==3)
    % Wiki case
    
    if (M ~= 2)
        error('Only two bacteria must be inserted (M=2)')
    end
    
    ke(1,1) = -1;
    ke(2,1) = -1;
    slope = 0;
    
    xtemp(1,1) = 0;
    ytemp(1,1) = 0;
    
    for i = 2:N
        xtemp(i,1) = xtemp(i-1,1) + (L/(N-1))*cos(slope); % meters
        ytemp(i,1) = ytemp(i-1,1) + (L/(N-1))*sin(slope); % meters
    end
    
    slope = pi/3;
    xtemp(1,2) = xtemp(1,1) + 2*L;
    ytemp(1,2) = ytemp(1,1) - 3*L;
    
    for i = 2:N
        xtemp(i,2) = xtemp(i-1,2) + (L/(N-1))*cos(slope); % meters
        ytemp(i,2) = ytemp(i-1,2) + (L/(N-1))*sin(slope); % meters
    end
    
end              

node = 0;

for j = 1:M
    for i = 1:N
        node = node + 1;
        r(node,1) = xtemp(i,j);
        r(node,2) = ytemp(i,j);
    end
end

end