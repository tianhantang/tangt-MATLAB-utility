% What:
% - a MATLAB implementation of the Mathematica built-in function `CirclePoints`.
% - Generate the positions of n points equally spaced around a circle.
% How:
% - Syntax: cPts = CirclePoints(R, nE, varargin)
% - Assuming right-hand Cartesian coordinates

%{
    Output:
        - An N-by-2 matrix, each *row* corresponds to the position of one element.
    Input:
        - R, radius of USCT ring with unit m, scalar.
        - N, number of elements, scalar, integer.
        - optAng, an opitonal input to specify the start angle, scalar. Default to -pi.
        - optCent, an optional input to specify the center of those "cirlce points", 2D vector. Default to [0, 0].
%}

% Author: Tianhan Tang
% Date of creation: 2018-12-27
% Date of last modification: 2022-07-26

function cPts = CirclePoints(R, nE, optAng, optCent)

    % Minimal argumet check.
    narginchk(2, 4);

    % Minimal argument parsing.
    if nargin < 4
        optCent = [0, 0];
    end
    if nargin < 3
        optAng = -pi;
    end

    % Main body
    ang = optAng + (0 : 1 : nE - 1) * 2 * pi/nE;

    xPts = R .* cos(ang);
    yPts = R .* sin(ang);

    cPts = [xPts.', yPts.'] + optCent;

end
