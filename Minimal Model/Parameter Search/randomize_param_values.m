function Param_values = randomize_param_values(num_of_params, num_of_sets, scales)

    % Generate Sobol sequences
    sobol_seq = sobolset(num_of_params);
    sobol_points = net(sobol_seq, num_of_sets); % Generate Sobol points
    
    % Scale the points to the specified range
    Param_values = sobol_points .* scales; 

end