function A_sub = subsystem_availability(n, k, Ergodic, standby)

    if standby == "hot" || standby == "warm"
        A_sub = sum(Ergodic(k+1:n+1));
    end
    if standby == "cold"
        A_sub = sum(Ergodic(2:n-k+2));
    end
end