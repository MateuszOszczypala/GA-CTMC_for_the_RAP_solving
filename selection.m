function parents = selection(X, A_s, num_select)
   
    Best_A_s = maxk(A_s, num_select);
    Sort_Best = sort(Best_A_s);
    j = 1;
    for a = 1:num_select
        for i = 1:num_select^2
            if A_s(i) == Sort_Best(num_select-a+1)
                parents(:,:,j) = X(:,:,i);
                A_s(i) = NaN;
                j = j + 1 ;
            end
        end
    end
    parents = parents(:,:,1:num_select);
end