%% CTMC matrix of transition intensity (Warm standby)

function L = CTMC_warm_standby(n_i, k, l_w, l_s, mi)

    % l_w failure rate for working component
    % l_s failure rate for standby component
    % mi repiar rate
    % n_i number of component in subsystem i
    % k mininal available components for system working
    
    L = zeros(n_i+1,n_i+1); % transition intensity matrix size declaration
    
    for j = 1:n_i+1
        for i = 1:n_i+1
            if i == j
                if j > k
                    L(j,i) = -((n_i - j + 1)*mi + k*l_w + (j - k - 1)*l_s);
                else
                    L(j,i) = -((n_i - j + 1)*mi + (j - 1)*l_s);
                end
            end
            if i == j - 1
                if j > k
                    L(j,i) = k*l_w + (j - k - 1)*l_s;
                else
                    L(j,i) = (j - 1)*l_s;
                end
            end
            if i == j + 1
                     L(j,i) = (n_i - j + 1)*mi;
            end
        end               
    end
end
