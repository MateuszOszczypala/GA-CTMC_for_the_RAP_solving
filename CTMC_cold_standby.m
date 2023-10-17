%% CTMC matrix of transition intensity (Cold standby)

function L = CTMC_cold_standby(n_i, k, l_w, mi)

    % failure rate for working component
    % repiar rate
    % number of component in subsystem i
    % mininal available components for system working
    
    L = zeros(n_i+1,n_i+1); % transition intensity matrix size declaration
    
    for j = k:n_i+1
        for i = k:n_i+1
            if i == j
                if i == k
                    L(j,i) = -((n_i - j + 1)*mi);
                else
                    L(j,i) = -((n_i - j + 1)*mi + k*l_w);
                end
                
            end
            if i == j - 1
                    L(j,i) = k*l_w;
            end
            if i == j + 1
                     L(j,i) = (n_i - j + 1)*mi;
            end
         end
    end
       
    L = L(k:n_i+1,k:n_i+1); % non-zero rows and columns
end