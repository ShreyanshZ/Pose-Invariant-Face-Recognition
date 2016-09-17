clc
clear all

Ip = strcat('E:\MATLAB\Programs\train\');
D = dir([Ip '*.jpg']);

Inputs = {D.name}';
Outputs = Inputs; % preallocate
Op = strcat('E:\MATLAB\Programs\FaceRec\train\');
% Ref image for brightness
Image1 = imread('ref.jpg');
Image1=imresize(Image1, [60,60]);
b1 = mean2(rgb2gray(Image1));
b1 =120.0;
for k = 1:length(Inputs)
I = imread([Ip Inputs{k}]); 
fd = vision.CascadeObjectDetector;
BB = step(fd,I);
newI = imcrop(I,BB);
% Intensity of current image
newI = rgb2gray(newI);
b2 = mean2(newI);
newI = imresize(newI, [60,60]);
% Adjust intensity and save
newI = newI + (b1-b2);
imwrite(newI,[Op Outputs{k}],'jpg');

% idx = k; % index number
% Outputs{k} = regexprep(Outputs{k}, ['input_' num2str(idx)]);

end
