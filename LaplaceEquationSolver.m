function [c] = LaplaceEquationSolver(x_min, x_max, NElem, D, bndry_1, bndry_1_val, bndry_2, bndry_2_val)
% Solves the discretised Laplace equation for a mesh
%   Detailed explanation goes here

 % Create mesh
msh = OneDimLinearMeshGen(x_min, x_max, NElem);
% Preallocate matrix sizes
RHS = zeros(NElem+1, 1);
GlobalMatrix = zeros(NElem+1);
% Iterate through elements, calculate the local matrix, add to GlobalMatrix
for elemId = 1 : NElem
    localElemMatrix = LaplaceElemMatrix(D, elemId, msh);
    GlobalMatrix = addToGlobalMatrix(GlobalMatrix, localElemMatrix, elemId);
end
% Apply boundary conditions
[GlobalMatrix, RHS] = applyBCs(GlobalMatrix, RHS, bndry_1,...
    bndry_1_val, bndry_2, bndry_2_val, NElem+1);
% Solve the system
c = GlobalMatrix\RHS;

end

