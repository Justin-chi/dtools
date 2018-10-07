function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%
for i = 1:size(X,1)
    distance_min = 100000000;
    idx_min = 100000000;
    for j = 1:K
        distance = sum((X(i,:) - centroids(j,:)).^2);
        if distance < distance_min
%            fprintf('found new distance and old distance_min[%f:%f]', distance, distance_min);
%            fprintf('found new idx and idx_min[%f:%f]', j, idx_min);
            distance_min = distance;
%            fprintf('found new distance_min[%f]', distance_min);
            idx_min = j
        end
    end
    idx(i) = idx_min;
end

% =============================================================

end

