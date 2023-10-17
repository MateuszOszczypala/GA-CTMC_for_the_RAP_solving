%% CTMC matrix of transition intensity (Hot standby)

function L = CTMC_hot_standby(n_i, l_w, mi)

    % n_i number of component in subsystem i
    % l_w failure rate for working component
    % mi repiar rate
    
    L = zeros(n_i+1,n_i+1); % transition intensity matrix size declaration
    
    for j = 1:n_i+1
        for i = 1:n_i+1
            if i == j
                L(j,i) = -((n_i - j + 1)*mi + (j - 1)*l_w);
            end
            if i == j - 1
                    L(j,i) = (j - 1)*l_w;
            end
            if i == j + 1
                     L(j,i) = (n_i - j + 1)*mi;
            end
        end                
    end
end
