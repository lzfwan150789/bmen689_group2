function [fractalBoundary] = getFractalBoundary(boundary)
    % Performing Box Counting...
	for r=2:7
		rc = @(x) floor(((max(x)-min(x))/r))+ 1; % non-linear filter
		F= colfilt(boundary, [r r],'sliding', rc);
		B{r}= log(double(F * (49/(r^2))));
	end
	close(h)

	i=log(2:7); % Normalised scale range vector

	%------- computing the slope using linear regression -------%
	Nxx=dot(i,i)-(sum(i)^2)/6;
	h = waitbar(0,'Transforming to FD...');
	for m = 1:M
		for n = 1:N
			fd= [B{7}(m,n), B{6}(m,n), B{5}(m,n), B{4}(m,n), B{3}(m,n), B{2}(m,n)]; % Number of boxes multiscale vector
			Nxy=dot(i,fd)-(sum(i)*sum(fd))/6; 
			FD{j}(m, n)= (Nxy/Nxx); % slope of the linear regression line
		end
		waitbar(m/M)
	end
	close(h)
	end
	
	% Computer Multi scale gradient descent
	
    fractalBoundary=-gradient(log(size(B,1)))./gradient(log(B));
    semilogx(B, fractalBoundary, 's-');
    ylim([0 dim]);
    xlabel('r, box size'); ylabel('- d ln n / d ln r, local dimension');
end