function [c] = DiffusionReactionVarySourceSolver(x_min, x_max, NElem, D, Lambda, k, bndry_1, bndry_1_val, bndry_2, bndry_2_val)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

 % Create mesh
msh = OneDimLinearMeshGen(x_min, x_max, NElem);

% Preallocate matrix sizes
RHS = zeros(NElem+1, 1);
GlobalMatrix = zeros(NElem+1);

% Iterate through elements, calculate the local matrix, add to GlobalMatrix
for elemId = 1 : NElem
    localDiffElemMatrix = LaplaceElemMatrix(D, elemId, msh);
    localRctnElemMatrix = LinearReactionElemMatrix(Lambda, elemId, msh);
    localElemMatrix = localDiffElemMatrix - localRctnElemMatrix;
    GlobalMatrix = addToGlobalMatrix(GlobalMatrix, localElemMatrix, elemId);
    RHS(elemId) = RHS(elemId) - k*msh.elem(elemId).x(1)*msh.elem(elemId).J;
    RHS(elemId+1) = RHS(elemId+1) - k*msh.elem(elemId).x(2)*msh.elem(elemId).J;
end
% Apply boundary conditions
[GlobalMatrix, RHS] = applyBCs(GlobalMatrix, RHS, bndry_1,...
    bndry_1_val, bndry_2, bndry_2_val, NElem+1);
% Solve the system
c = GlobalMatrix\RHS;

end

