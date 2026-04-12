function fail = failure(T, startJoints, endJoints, load)
    %load is the force we put dow

    %preallocations 
    M = length(mj);
    buck_load = zeros(M);
    buck_load_min = zeros(M);
    buck_load_max = zeros(M);
    ratio = zeros(M);
    fload = zeros(M);

    for m = 1:M
        %gets the buckling force 
        buck_load(m) = C*((L_0/load)^a);
        %min and max from uncertainty
        buck_load_min(m) = buck_load(m) - U_fit;
        buck_load_max(m) = buck_load(m) + U_fit; 

        %gets the ratio so we can see if the members are in tension or compression
        ratio(m) = T(m) / load;
        if ratio(m) < 0
            %buckling occurs only in compression
            fload(m) = (-1*buck_load(m))/ratio(m);
        else
            %in tension so no buckling
            fload(m) = inf;
        end 
    end
    %smallest positive value is the critical member
    w_failure = min(fload);
    %return with the critical member and load
    fail = w_failure;
    %get which joint number the critical member is
    [fail, i] = min(fload)

end


           
