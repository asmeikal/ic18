
% findIdentifiable  Find all k-identifiable nodes from a test matrix.
%   V = findIdentifiable(T, k) returns all k-identifiable nodes of test
%   matrix T.
%
%   V = findIdentifiable(T, k, ID) uses identifiability matrix ID instead
%   of computing it from scratch. Test matrix T is ignored.
%
%   [V, ID] = findIdentifiable(T, k) computes the identifiability matrix
%   and returns it in return value ID.
function [V, varargout] = findIdentifiable(testMatrix, k, varargin)
    % check input/output arguments number
    if (nargin == 3 && nargout == 2)
        error(['Either you give the identifiability matrix' ...
                'or you let me compute it!']);
    end
    % get identifiability matrix from input or compute it
    if (nargin > 3)
        error("Too many input arguments.");
    elseif (nargin == 3)
        % identifiability matrix was given by the user
        ID = cell2mat(varargin(1));
    else
        % compute identifiability matrix for given k
        ID = buildIdentifiabilityMatrix(testMatrix, k);
    end
    % store identifiability matrix if requested
    if (nargout > 2)
        error("Too many output values.");
    elseif (nargout == 2)
        varargout(1) = {ID};
    end
    % find k-identifiable nodes
    V = find(ID(k,:));

end
