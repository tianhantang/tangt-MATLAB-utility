% Compute the distances between any point (in dimension d) in set X and any other point in set Y.
% Syntax: distance_map = fP2P(point_group_1, point_group_2)

%{
    Output:
        - D, a N1-by-N2 matrix, w/ each ij be the distance from x_i to y_j.
    Input:
        - X, a d-by-N1 matrix, each column be a vector for a point in set X.
        - Y, a d-by-N2 matrix, each column be a vector for a point in set Y.
    NOTE:
        - No argument check w/ the assumption that the user should know what he/she is doing.
%}

% Author: Tianhan Tang
% Date of creation: 2019-01-24
% Date of last modification: 2019-01-24

function D = fP2P(X, Y)

    % Implicit dimension expansion is incurred
    D = sqrt(dot(X, X, 1).' + dot(Y, Y, 1) - 2 * (X.' * Y));
    
end
