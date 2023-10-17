function c_standby = components_placement(N, K, m, w)
    for i = 1:m
        a(i) = (w(i)/sum(w))*(N-K);
        c_standby(i) = floor(a(i));
    end
    
    if sum(c_standby) ~= N-K
        r = N-K-sum(c_standby);
        d = a-c_standby;
        f = 0;
        for j = 1:r
            d_max = max(d);
            for i = 1:m
                if f < r
                    if d(i) == d_max
                       c_standby(i) = c_standby(i) + 1;
                       d(i) = 0;
                       f = f + 1;
                    end
                end
            end
        end
    end
end