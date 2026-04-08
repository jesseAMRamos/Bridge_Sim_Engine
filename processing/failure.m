function fail = failure(T, startJoints, endJoints, load)
    %load is the force we put down
    %constants needed for load buckling relationship
    C = 37.5;
    L_0 = 10;
    a = 2;
    U_fit = 10;

   
    M = size(startJoints, 1);
    buck_load = zeros(M);
    buck_load_min = zeros(M);
    buck_load_max = zeros(M);
    for m = 1:M
        %gets the length of the members 
        magn(m) = sqrt((endJoints(m,1)-startJoints(m,1))^2+(endJoints(m,2)-startJoints(m,2))^2);
        %gets the buckling load force
        buck_load(m) = C*((L_0/magn(m))^a);

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
    [fail, i] = min(fload);

end


           
