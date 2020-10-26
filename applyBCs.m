function [GlobalMatrix, RHS] = applyBCs(GlobalMatrix, RHS, bndry_1, bndry_1_val, bndry_2, bndry_2_val, NNodes)
% Applies boundary conditions to left hand and right hand sides of system
%   Detailed explanation goes here

% Apply boundary condition at lower limit
if(bndry_1 == "Nman") % Neumann
    RHS(1) = RHS(1) - bndry_1_val;
elseif(bndry_1 == "Dlet") % Dirichlet
    % Set the RHS to given value
    RHS(1) = bndry_1_val;
    % Set diagonal entry to 1
    GlobalMatrix(1, 1) = 1;
    % Zero out the rest
    for i = 2:NNodes
        GlobalMatrix(1,i) = 0;
    end
end

% Apply boundary condition at upper limit
if(bndry_2 == "Nman")
    RHS(NNodes) = RHS(NNodes) + bndry_2_val;
elseif(bndry_2 == "Dlet")
    RHS(NNodes) = bndry_2_val;
    for i = 1:NNodes-1
        GlobalMatrix(NNodes,i) = 0;
    end
    GlobalMatrix(NNodes, NNodes) = 1;
end

end

