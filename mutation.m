function offspring_mutated = mutation(offspring)
       
    for z = 1:(size(offspring, 3)^(1/2))
        par(z) = (z-1)*(size(offspring, 3)^(1/2)) + z;
    end

    prob_mut = 0.05; % probability of mutation
    for i = 1:size(offspring,3) 
        if ~ismember(i, par)
            for j = 1:size(offspring,2)
                   for l = 1:size(offspring,1)
                          
                            if rand(1) <= prob_mut
                                offspring_mutated(l,j,i) = abs(offspring(l,j,i)-1);
                            else
                                offspring_mutated(l,j,i) = offspring(l,j,i);
                            end
                       
                    end             
            end
        else
          offspring_mutated(:,:,i) = offspring(:,:,i);
        end
    end

end