clc, clearvars, close;

I = imread("curr.jpg");

Y = fft2(I);
% disp(Y);

image(abs(X));