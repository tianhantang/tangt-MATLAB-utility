% @file:       Clip.m
% @brief:      Clip input value between a range.
% @usage:      y = Clip(in_data, lower_limit, upper_limit)

%{
	@param[out]: 
		- y, clipped array of the same size as input.
	@param[in]:
		- x, input array or matrix.
		- bl, lower boundary.
		- bu, upper boundary.

	@note:
		- It is MATLAB implementation of the Mathematica built-in function `Clip`.
		- Idea obtained from [MATLAB forum](https://www.mathworks.com/matlabcentral/answers/123097-function-for-limit-range).
%}

% @author: Tianhan Tang (tianhantang.pd@gmail.com)
% @date:
% - created on 2019-08-06
% - updated on 2022-06-23

function y = Clip(x, bl, bu)

    % @note: there is NO ARGUMENT CHECK---user should ensure bl, bu are scalar and bl < bu.
	x(x > bu) = bu;
	x(x < bl) = bl;

	y = x;

end
