
% maxIdentifiable  Find max k for which the graph has a k-identifiable
% node.
%   k =  maxIdentifiable(T) returns the max k for which test matrix T has a
%   k-identifiable node.
%
%   k = maxIdentifiable(T, ID) uses identifiability matrix ID instead
%   of computing it from scratch. Test matrix T is ignored.
%
%   [k, ID] = maxIdentifiable(T) computes the identifiability matrix
%   and returns it in return value ID.
function [k, varargout] = maxIdentifiable(testMatrix, varargin)
    % check input/output arguments number
    if (nargin == 2 && nargout == 2)
        error(['Either you give the identifiability matrix' ...
                'or you let me compute it!']);
    end
    % store number of nodes
    nNodes = size(testMatrix,2);
    % get identifiability matrix from input or compute it
    if (nargin > 2)
        error("Too many input arguments.");
    elseif (nargin == 2)
        ID = cell2mat(varargin(1));
    else
        % compute identifiability matrix up to nNodes - 1
        ID = buildIdentifiabilityMatrix(testMatrix, nNodes-1);
    end
    % store identifiability matrix if requested
    if (nargout > 2)
        error("Too many output values.");
    elseif (nargout == 2)
        varargout(1) = {ID};
    end
    % find last non-zero row in identifiability matrix
    k = find(arrayfun(@(i) any(ID(i,:)), 1:(nNodes-1)), 1, 'last');
end