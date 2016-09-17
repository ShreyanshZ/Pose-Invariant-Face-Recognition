clear all
input_dir = 'C:\Users\Umang Shah\Documents\MATLAB\FaceRec\train';
image_dims = [60, 60];
filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images = [];

for n = 1:num_images
   
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
    
%    img = rgb2gray(img);
    img = im2double(img);
    if n == 1
        images = zeros(prod(image_dims), num_images);
    end
    img = imresize(img,image_dims);
    images(:, n) = img(:);
%         images(:, n) = reshape(img(:),[],1);
end

% steps 1 and 2: find the mean image and the mean-shifted input images
mean_face = mean(images,2);
shifted_images = images - repmat(mean_face,1, num_images);
 
% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = princomp(images');
%  [COEFF,SCORE,latent] = princomp(images);

% step 5: only retain the top 'num_eigenfaces' eigenvectors (i.e. the principal components)
num_eigenfaces = 11;
evectors = evectors(:, 1:num_eigenfaces);
 
% step 6: project the images into the subspace to generate the feature vectors
features = evectors' * shifted_images;

% % --------- Classification --------- %
input_image = imread('C:\Users\Umang Shah\Documents\MATLAB\FaceRec\testing\1.jpg');
%  input_image= rgb2gray(input_image);
    input_image = im2double(input_image);
    input_image = imresize(input_image,image_dims);
% % calculate the similarity of the input to each training image
feature_vec = evectors' * (input_image(:) - mean_face);
similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);
%  
% % find the image with the highest similarity
[match_score, match_ix] = max(similarity_score);
%  
% % display the result
figure, imshow([input_image reshape(images(:,match_ix), image_dims)]);
title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));