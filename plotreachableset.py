# -*- coding: utf-8 -*-
"""
Created on Wed Mar 22 15:55:21 2023

@author: dekom
"""
#Define system matrices
A = [1 1; 0 1];
B = [0; 1];
Q = [1 0; 0 1];  % state cost matrix
R = 1;  % control cost matrix

#Calculate the control gain matrix using LQR
[K, P] = lqr(A, B, Q, R);

#Define the range of x1 and x2 values
x1 = -5:0.1:5;
x2 = -5:0.1:5;

#Create a meshgrid of x1 and x2 values
[X1, X2] = meshgrid(x1, x2);

#Calculate the values of the quadratic function
Z = zeros(size(X1));
for i = 1:numel(X1)
    x = [X1(i); X2(i)];
    Z(i) = x.' * P * x;
end

#Plot the boundary of the reachable set
contour(X1, X2, Z, [1 2 3 4], 'LineColor', 'r', 'LineWidth', 2)

% Add labels and title
xlabel('x1')
ylabel('x2')
title('Reachable Set')
