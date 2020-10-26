function [elemat] = LaplaceElemMatrix(D,eID,msh)
% Returns the local element matrix for the diffusion term
%   Detailed explanation goes here

% Fetch Jacobian for this element from mesh
Jcbn = msh.elem(eID).J;
% Calculate derivatives
dXi_dx = 2 / ((msh.elem(eID).x(2)) - (msh.elem(eID).x(1)));
dPsi_dx = [-0.5, 0.5];
% Calculate local element values
elemat(1,1) = D * dPsi_dx(1) * dXi_dx * dPsi_dx(1) * dXi_dx * Jcbn * 2;
elemat(1,2) = D * dPsi_dx(1) * dXi_dx * dPsi_dx(2) * dXi_dx * Jcbn * 2;
elemat(2,1) = elemat(1,2);
elemat(2,2) = D * dPsi_dx(2) * dXi_dx * dPsi_dx(2) * dXi_dx * Jcbn * 2;

end

