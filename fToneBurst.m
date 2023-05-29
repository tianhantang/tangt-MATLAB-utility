% Generate a *function* of Gaussian modulated toneburst

%{
	Output:
		- func, a function handle of time vector
	Input:
		- amp, amplitude of the toneburst (sinusoid) to be modulated
		- fc, central frequency of the sinusoid wave
		- dur, duration of the modulated pulse
	Example:
		- fc = 2.5e+6; dur = 4/fc; tvec = 1/(31.25e+6) * (0:1:100);
		- pulse = feval(fToneBurst(100, fc, dur), tvec);
		- plot(pulse);
	Misc:
		- naming convetion is unified w/ UT_2022_12_25_a.nb of stack 2023-01-08-a
%}

% Author: Tianhan Tang
% Date of creation: 2019-06-15
% Date of last modification: 2023-05-29

function func = fToneBurst(amp, fc, dur)
	
	% NO argument check

	% continuous single wave function
	cw_ = fSinusoid(amp, fc, 0);

	% window function
	window_ = fRecWin(dur);

	% Gaussian weight
	weight_ = fGaussianWeight(dur/2, 0.01);

	% tvec is a row vector
	func = @(tvec) cw_(tvec) .* window_(tvec) .* weight_(tvec);

end

% ////////////////////////////////////////////////////////////////
% ///////////////////////SUB FUNCTIONS ///////////////////////////
% --------------------------------
function func = fSinusoid(amp, fc, phi)

	omega = 2*pi*fc;
	% tvec is a row vector
	func = @(tvec) amp .* sin(omega * tvec + phi);

end
% --------------------------------
function func = fRecWin(dur)

	% tvec is a row vector
	func = @(tvec) (tvec >= 0 & tvec <= dur) * 1;		

end
% --------------------------------
function func = GaussianFcn(a, b, c)
	
	% tvec is a row vector
	func = @(tvec) a * exp(-(tvec - b).^2 / (2 * c^2));

end
% --------------------------------
function func = fGaussianWeight(b, par)

	c2 = -b^2 / (2*log(par));
	% tvec is a row vector
	func = GaussianFcn(1, b, sqrt(c2));

end
