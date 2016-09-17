input_dir = 'train/';

filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images = [];

for n = 1:num_images
   
    filename = fullfile(input_dir, filenames(n).name);
    image = imread(filename);
   % figure, imshow(image);
    
    k=n;
    N=num_images;M=9;
    img = cell([N,M]);
    faceDetector = vision.CascadeObjectDetector;
    faceDetector.MergeThreshold = 10;
    BB = step(faceDetector, image);
    F=imcrop(image,BB);
b2 = mean2(rgb2gray(F));
F = F + (120-b2);
    grayImage = imresize(F, [90,90]);
    figure,imshow(rgb2gray(grayImage));
% 
%     [rows, columns, numberOfColorChannels] = size(grayImage);
%     r3 = int32(rows/3);
%     c3 = int32(columns/3);
%     
%     % Extract the 9 images.
%   
%     img{k}{1} = grayImage(1:r3, 1:c3);
%     %figure,imshow(img{k}{1})
%     S1=sprintf('\\train\\s1\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{1},storepath,'jpg')
%   
%     
%     img{k}{2} = grayImage(1:r3, c3+1:2*c3);
%     %figure,imshow(img{k}{2})
%     S1=sprintf('\\train\\s2\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{2},storepath,'jpg')
%   
%     
%     img{k}{3} = grayImage(1:r3, 2*c3+1:3*c3);
%     %figure,imshow(img{k}{3})
%     S1=sprintf('\\train\\s3\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{3},storepath,'jpg')
%     
%     
%     img{k}{4} = grayImage(r3+1:2*r3, 1:c3);
%     %figure,imshow(img{k}{4})
%     S1=sprintf('\\train\\s4\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{4},storepath,'jpg')
%  
%     
%     img{k}{5} = grayImage(r3+1:2*r3, c3+1:2*c3);
%     %figure,imshow(img{k}{5})
%     S1=sprintf('\\train\\s5\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{5},storepath,'jpg')
%   
%     
%     img{k}{6} = grayImage(r3+1:2*r3, 2*c3+1:3*c3);
%     %figure,imshow(img{k}{6})
%     S1=sprintf('\\train\\s6\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{6},storepath,'jpg')
%   
%     
%     img{k}{7} = grayImage(2*r3+1:end, 1:c3);
%     %figure,imshow(img{k}{7})
%     S1=sprintf('\\train\\s7\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{7},storepath,'jpg')
%  
%     
%     img{k}{8} = grayImage(2*r3+1:end, c3+1:2*c3);
%     %figure,imshow(img{k}{8})
%     S1=sprintf('\\train\\s8\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{8},storepath,'jpg')
%    
%     
%     img{k}{9} = grayImage(2*r3+1:end, 2*c3+1:3*c3);
%     %figure,imshow(img{k}{9})
%     S1=sprintf('\\train\\s9\\');
%     storepath=fullfile(S1,filenames(n).name);
%     imwrite(img{k}{9},storepath,'jpg')
%     
%     
%     
%     
end
display 'end'