% "Clip" input value between a range.
% Syntax: y = Clip(in_data, lower_limit, upper_limit)

%{
    @param[out]: 
        - y, clipped array of the same size as input
    @param[in]:
        - x, input array or matrix.
        - bl, lower boundary.
        - bu, upper boundary
    @note:
        - It is MATLAB implementation of the Mathematica built-in function `Clip`.
        - Idea obtained from Internet: https://www.mathworks.com/matlabcentral/answers/123097-function-for-limit-range
%}

% Author: Tianhan Tang
% Date of creation: 2019-08-06
% Date of last modification: 2022-06-23

function y = Clip(x, bl, bu)

    % NO ARGUMENT CHECK.
    % @note, user should ensure bl, bu are scalar and bl < bu.
	x(x > bu) = bu;
	x(x < bl) = bl;

    y = x;

end
