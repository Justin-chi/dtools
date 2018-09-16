function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
fprintf('m :%f \n', m);
fprintf('num_lables :%f \n', num_labels);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

%fprintf('theta1:%f', Theta1);
%fprintf('theta2:%f', Theta2);
fprintf('sizeof y :%f %f \n', size(y,1), size(y',1));
y = eye(num_labels)(y,:);
fprintf('sizeof X :%f %f \n', size(X,1), size(X',1));
fprintf('sizeof y :%f %f \n', size(y,1), size(y',1));
a1 = X;
fprintf('sizeof a1 :%f %f \n', size(a1,1), size(a1',1));
a1 = [ones(m,1) a1];
fprintf('sizeof a1 :%f %f \n', size(a1,1), size(a1',1));
z2 = a1*Theta1';
a2 = sigmoid(z2);
fprintf('sizeof a2 :%f %f \n', size(a2,1), size(a2',1));
a2 = [ones(m,1) a2];
fprintf('sizeof a2 :%f %f \n', size(a2,1), size(a2',1));
z3 = a2*Theta2';
h = sigmoid(z3);
fprintf('sizeof h :%f %f \n', size(h,1), size(h',1));

J = 1/m*(sum(sum(-y.*log(h)-(1-y).*log(1-h))))
fprintf('sizeof J :%f %f \n', size(J,1), size(J',1));

T1 = Theta1(:,2:end);
fprintf('sizeof T1 :%f %f \n', size(T1,1), size(T1',1));

T2 = Theta2(:,2:end);
fprintf('sizeof T2 :%f %f \n', size(T2,1), size(T2',1));

r = lambda/(2*m)*(sum(sum(T1.^2))+sum(sum(T2.^2)));

J = J + r;
% -------------------------------------------------------------
%part2

e3 = h - y;

fprintf('sizeof Theta2 :%f %f \n', size(Theta2,1), size(Theta2',1));
fprintf('sizeof e3 :%f %f \n', size(e3,1), size(e3',1));

e2 = e3 * Theta2;
fprintf('sizeof e2 :%f %f \n', size(e2,1), size(e2',1));
e2 = e2(:,2:end);
fprintf('sizeof e2 :%f %f \n', size(e2,1), size(e2',1));
e2 = e2.* sigmoidGradient(z2);
fprintf('sizeof e2 :%f %f \n', size(e2,1), size(e2',1));

E2 = zeros(size(Theta2));
E1 = zeros(size(Theta1));

E2 = E2 + e3'*a2; 
E1 = E1 + e2'*a1;

Theta1_grad = 1/m*(E1);
Theta2_grad = 1/m*(E2);


% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
