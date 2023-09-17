% Calculate Line Circle Intersection
% Syntax: [X, Y, intersection_length, line_segment_length] = circXLine(EP1, EP2, cent, R, mode)

%{
    Output:
        - 1 output case, intLen, intersection length
        - 2 output case, [intG1, intpG2], coordinates of the intersection points, 2 per circle
        - 3 output case, [intG1, intpG2, intLen]
        - 4 output case, [intG1, intpG2, intLen, len], len is the point to point distance.
			- intG1, "entering" point, dim-by-N0-by-N1-by-N2
			- intG2, "leaving" point, dim-by-N0-by-N1-by-N2
			- intLen, intersection length, 1-by-N0-by-N1-by-N2
			- len, point to point distance, 1-by-1-by-N1-by-N2
    Input:
        - EP1, one of the endpoints of the line segment(s), dim-by-N1 matrix.
        - EP2, antoher endpoint of the line segment(s), dim-by-N2 matix.
        - cent, center of the circle/sphere, dim-by-N0.
        - R, radius of the circle/sphere, 1-by-N0 array.
        - mo, [Optional], mode, 'line'|'segment', to specify whether line or line segment is under consideration.
    NOTE:
        - Line is represented parametrically, as x = x0 + Dot[n, t], and intersection is calculated by inserting the expression of line into ||x - c||^2 = r^2.
		- Refer to Log_20190906.key p.32 for a note
%}

% Author: Tianhan Tang
% @when:
% - date of creation: 2019-08-26
% - dte of last modification: 2021-12-01

function varargout = circXLine(EP1, EP2, cent, R, varargin)

	% Minial argument check
	narginchk(4, 5);
	nargoutchk(1, 4);

	if length(varargin) >= 1
		mo = varargin{1};
	else
		mo = 'line';
	end

	% dimension check
    [dim, N0] = size(cent);
	[~, N1] = size(EP1);
	[~, N2] = size(EP2);

	tol = eps('single');
	% line segment length (N1-by-N2 matrix)
	len = reshape(fP2P(EP1, EP2), [1, 1, N1, N2]); % 1-1-N1-N2

	% safety check, if there is overlapping between EP1 set and EP2 set
	if any(len < tol, 'all')
		warning('BAD point sets, overlapping detected!');
	end

	% dimension expansion
	EP1 = reshape(EP1, [dim, 1, N1, 1]);
	EP2 = reshape(EP2, [dim, 1, 1, N2]);

	% unit directive vecotr (EP1 -> EP2)
	n = (EP2 - EP1) ./ len; % dim-1-N1-N2
	co = EP1 - cent; % dim-N0-N1-1

	% vector from endpoint to center of circle/sphere
    var1 = dot(repmat(n, [1, N0, 1, 1]), repmat(co, [1, 1, 1, N2])); % 1-N0-N1-N2
    var2 = dot(co, co, 1); % 1-N0-N1-1

	% discriminant of intersection
	dmt = var1.^2 - var2 + R.^2; % 1-N0-N1-N2 (R: 1-N0)

	% Three cases
	% 1. No intersection, dmt < 0
	% 2. Tangent, dmt == 0
	% 3. Cross, dmt > 0
	dmt(dmt < 0) = NaN;
	t = -var1 + sqrt(dmt) .* ([-1, 1].');
	% calculate the length of intersection, if required
	% - for line mode, only two cases needs to be considered
	% - for segment mode, 4 parameters are involved, i.e., t1, t2, 0, len
	if nargout ~= 2
		par = zeros(1, N0, N1, N2);
		switch mo
			case 'line'				
				par = diff(t, 1, 1);
				par(isnan(par)) = 0;				
			case 'segment'
                metric = cat(1, ...
                    t >= 0, ...
                    t <= len ...
                );
				% >
					t1 = t(1, :, :, :);
					t2 = t(2, :, :, :);	
					ll = repmat(len, [1, N0, 1, 1]);
				% <				
				i4 = ~any(metric - ([1, 1, 1, 0].'), 1);
				par(i4) = ll(i4) - t1(i4);
				i5 = ~any(metric - ([0, 1, 1, 1].'), 1);
				par(i5) = t2(i5);
				i6 = ~any(metric - ([0, 1, 1, 0].'), 1);
				par(i6) = ll(i6);
				i7 = ~any(metric - ([1, 1, 1, 1].'), 1);
				par(i7) = t2(i7) - t1(i7);
			otherwise
				error('Invalid mode!');
		end
	end

	% calculate the intersection points, if required
	if nargout ~= 1
		% Handle the line segmenta case (further constrain via mask)
		if strcmp(mo, 'segment')
			t(t < -tol | (t - len) > tol) = NaN;
		end
		
		intG1 = EP1 + t(1, :, :, :) .* n;
		intG2 = EP1 + t(2, :, :, :) .* n;
		
	end

	% Assemble the output
	switch nargout
		case 1
			[varargout{1}] = par;
		case 2
			[varargout{1:2}] = deal(intG1, intG2);
		case 3
			[varargout{1:3}] = deal(intG1, intG2, par);
		case 4
			[varargout{1:4}] = deal(intG1, intG2, par, len);
	end

end
