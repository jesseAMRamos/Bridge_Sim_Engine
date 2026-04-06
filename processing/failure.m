%definintion of inputs would be nice
function fail = failure(mj, magn, load)
    %constants needed for load buckling relationship
    C = 37.5;
    L_0 = 10;
    a = 2;
    U_fit = 10;

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


        %gets the ratio so we can see if the members are in tension or
        %compression
        ratio(m) = mj(m) / load;
        if ratio(m) < 0
            %buckling occurs only in compression
            fload(m) = (-1*buck_load(m))/ratio(m);
        else
            %in tension so no buckling
            fload(m) = 0;
        end
    end
    %smallest positive value is the critical member
    w_failure = min(fload);
    %return with the critical member and load
    fail = w_failure;
    [fail, i] = min(fload)

end


           