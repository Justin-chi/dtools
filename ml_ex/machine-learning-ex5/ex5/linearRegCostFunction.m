function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

%fprintf('X size is:[%f:%f] \n', size(X,1), size(X',1));
%fprintf('theta size is:[%f:%f] \n', size(theta,1), size(theta',1));
%fprintf('theta length is:[%f] \n', length(theta));
%fprintf('y size is:[%f:%f] \n', size(y,1), size(y',1));
%fprintf('lambda size is:[%f:%f] \n', size(lambda,1), size(lambda',1));

h = X*theta;
%J = sum(power(h-y,2))/(2*m) + lambda*((theta'*theta -theta(1))^2)/(2*m);
J = sum(power(h-y,2))/(2*m) + lambda*(sum(theta(2:end,:) .^ 2))/(2*m);

mask = ones(size(theta));
mask(1) = 0;

grad = ((h-y)'*X)'/m + lambda*(theta.*mask)/m

% =========================================================================

grad = grad(:);

end
