% Creates a regular (2D) pixel grid on which the image reconstruction is performed
% Syntax: posGrd = RegularGrid(dP, nP, oP)

%{
    Output:
        posGrd, 2-by-N (number of grids) matrix
		optional output is available, pleae see the source code
    Input:
        - dP, dP = [dx, dy], grid size
            - dx, pixel grid size, in x-direction (2D Cartesian convention)
            - dy, pixel grid size, in y-direction (2D Cartesian convenstion)
        - nP, nP = [nx, ny], number of grids
            - n1, number of pixels in x-direction
            - n2, number of pixels in y-direction
        - oP, oP = [ox, oy], origin
    NOTE:
        - Utilized MATLAB built-in function `meshgrid`.
        - The grid is guaranteed to be symmetrical about the origin.
        - The order of y coordinates is revesred so that it is convenient to relate image grid index (usually starts from (1,1) at upper-left corner) and physical coordinates (usually has horizontal x-axis and vertical y-axis, following right-hand rule).
		- The illustration of the relation between the MATLAB 2-dimension array indexing and the Cartesian coordinates convention is as follow

		O---> 2nd dim
		|		_|_|_|_|_|_|_|_|_|_
		|		_|_|_|_|_|_|_|_|_|_
		V		_|_|_|_|_|_|_|_|_|_
		1st-dim	_|_|_|_|_|_|_|_|_|_
				_|_|_|_|_|_|_|_|_|_
				_|_|_|_|_|_|_|_|_|_
		^		 | | | | | | | | |
		| Y-direction
		|
		O---> X-direction

		- What is returned is the coordinate at grid center, not at grid corner.

	Misc:
		- naming convetion is unified w/ UT_2022_12_25_a.nb of stack 2023-01-08-a
%}

% Author: Tianhan Tang
% Date of creation: 2019-01-24
% Date of last modification: 2021-03-14

function varargout = createRegularGrid(dP, nP, oP)

    xlin = ((1 : 1 : nP(1)) - (nP(1) + 1) / 2) * dP(1) + oP(1);
    ylin = ((nP(2) : -1 : 1) - (nP(2) + 1) / 2) * dP(2) + oP(2);

    [xx, yy] = meshgrid(xlin, ylin);

    posGrd = [xx(:), yy(:)];

    switch nargout
        case 1
            [varargout{1}] = posGrd;
        case 2
            [varargout{1:2}] = deal(xlin, ylin);
        case 3
            [varargout{1:3}] = deal(posGrd, xlin, ylin);
    end

end
