clear all;
clc;

%READ AN INPUT IMAGE
A=imread('cameraman.tif');

Nearest_neighbur(A, 5);
%Bicubic(A,0.5);
