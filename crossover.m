function offspring = crossover(parents, num_select)
    
    for i = 1:num_select
        for j = 1:num_select
            offspring(:,1:4,(i-1)*num_select+j) = parents(:,1:4,i);
            offspring(:,5:8,(i-1)*num_select+j) = parents(:,5:8,j);
        end
    end
end