clc
clear all
Ip = 'C:\Users\Umang Shah\Desktop\IMFDB_final\testimages\';
D = dir([Ip '*.jpg']);
Inputs = {D.name}';
Outputs = Inputs; % preallocate
Op = 'C:\Users\Umang Shah\Documents\MATLAB\FaceRec\testing\';

for k = 1:length(Inputs)
I = imread([Ip Inputs{k}]);
fd = vision.CascadeObjectDetector;
BB = step(fd,I);
newI = imcrop(I,BB(2,:));
newI = imresize(newI, [60,60]);
%  figure,
% imshow(I); hold on
% for i = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
% end
% title('Face Detection');
% hold off;
% imshow(newI);
newI = rgb2gray(newI);
idx = k; % index number
% Outputs{k} = regexprep(Outputs{k}, ['input_' num2str(idx)]);
imwrite(newI,[Op Outputs{k}],'jpg');
end
