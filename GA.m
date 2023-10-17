%% Genetic algorithm for RAP
initime = cputime;
% total number of components N
N = 130;

% number of subsystems
m = 10;

% minimal number (k) for subsystems
k = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

% sum of all k number
K = sum(k);

% standby
standby = "hot";

% l_w failure rate for working component
l_w = 0.1;

% l_s failure rate for standby component
l_s = 0.05;

% mi repiar rate
mi = 0.25;

% population size
pop_size = 64;

% number of generation
generation = 50;

% number of selected parents
num_select = pop_size^(0.5);

% size declaration
n(1:m,1:pop_size,1:generation) = NaN; % total number of components in subsystem

% X(gen(binary value), chromosome(subsystem), system, generation)
X(1:m, 1:8, 1:pop_size, 1:generation) = NaN;

% initial generation
for pop = 1:pop_size
    for f = 1:m
       gen = randi([0 1], 1, 8);
       X(f, 1:8, pop, 1) = gen;
    end
end
% bin2dec(num2str(X(...)))
for num_gen = 1:generation
    % Evaluation of systems configuration
    for pop = 1:pop_size

        % Decoding the chromosomes
        w = decode(m, X(1:m, 1:8, pop, num_gen));
       
        % Components placement
        c_standby = components_placement(N, K, m, w); % number of standby components
        n(1:m,pop,num_gen) = k + c_standby;  

        % Calculate the component availability and unavailability
        for j = 1:m

            % Create the CTMC model for the subsystems
            if standby == "hot"
            L = CTMC_hot_standby(n(j,pop,num_gen), l_w, mi); % L - transition matrix
            end
            if standby == "warm"
            L = CTMC_warm_standby(n(j,pop,num_gen), k(j), l_w, l_s, mi); % L - transition matrix
            end
            if standby == "cold"
            L = CTMC_cold_standby(n(j,pop,num_gen), k(j), l_w, mi); % L - transition matrix
            end
            % Calculate ergodic probabilities
            Ergodic = Ergodic_prob(L)';
            
            % Calculate the subsystem availability         
            A_sub(j) = subsystem_availability(n(j,pop,num_gen), k(j), Ergodic, standby);
            
        end   

        % Calculate the system availability
        A_s(num_gen, pop) = system_availability(A_sub);
        clear A_sub;               
    end
    % Selection parents for next generation
    parents = selection(X(1:m, 1:8, 1:pop_size, num_gen), A_s(num_gen,:), num_select);

    % Crossover
    offspring = crossover(parents, num_select);
    
    % Mutation
    offspring = mutation(offspring);

    % Save the offspring as a new generation
    X(1:m, 1:8, 1:pop_size, num_gen+1) = offspring;
end

% Find the best result
Highest_availability = max(A_s,[],"all");

% Find the best configuration
   
    for i = 1:pop_size
        for j = 1:generation
            if A_s(j,i) == Highest_availability
                Best_configuration = n(:,i,j);
            end
        end
    end

% computation time
fintime = cputime;
computation_time = fintime - initime;

% The best results in each generation
improvement = max(A_s,[],2);
% plot(1:generation, improvement);
