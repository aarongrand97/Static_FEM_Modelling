function [globalMatrix] = addToGlobalMatrix(globalMatrix,localElemMatrix, elemID)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
globalMatrix(elemID, elemID) = globalMatrix(elemID, elemID) + localElemMatrix(1,1);
globalMatrix(elemID, elemID+1) = globalMatrix(elemID, elemID+1) + localElemMatrix(1,2);
globalMatrix(elemID+1, elemID) = globalMatrix(elemID+1, elemID) + localElemMatrix(2,1);
globalMatrix(elemID+1, elemID+1) = globalMatrix(elemID+1, elemID+1) + localElemMatrix(2,2);
end

