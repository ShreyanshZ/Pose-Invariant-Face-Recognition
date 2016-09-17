clc
clear all
input_dir = 'C:\Users\Umang Shah\Documents\MATLAB\AeroFS\TestingFeatureBased\TrainFaces\';
faceGallery = imageSet(input_dir, 'recursive');
num_images = numel(faceGallery);
image_dims = [86,126];
% filenames = dir(fullfile(input_dir, '*.jpg'));
% num_images = numel(filenames);

images = zeros(prod(image_dims), num_images*3);
featureCount = 1;
for i=1:size(faceGallery,2)
    for j = 1:faceGallery(i).Count
        img = rgb2gray(read(faceGallery(i),j));
        img = imresize(img,image_dims);
        img = im2double(img);
        
        images(:, featureCount) = img(:);
        trainingLabel{featureCount} = faceGallery(i).Description; 
        featureCount = featureCount + 1;
    end
    personIndex{i} = faceGallery(i).Description;
end


mean_face = mean(images,2);
shifted_images = images - repmat(mean_face,1, num_images*3);

% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = princomp(images');

num_eigenfaces = 30;
evectors = evectors(:, 1:num_eigenfaces);
 
% step 6: project the images into the subspace to generate the feature vectors
features = evectors' * shifted_images;

classifier = fitcecoc(features',trainingLabel);
%% 
% figure;
% plot(classifier);
name = 'classifier.mat';
save(name);
display('Saved');
%% 
clc
testSet = imageSet('C:\Users\Umang Shah\Documents\MATLAB\AeroFS\TestingFeatureBased\test90\');

for  i= 1: testSet.Count
    
    I = read(testSet,i);
    input_image = rgb2gray(imresize(I, [86,126]));
  input_image = im2double(input_image);

  % % calculate the similarity of the input to each training image
feature_vec = evectors' * (input_image(:) - mean_face);
matched = predict(classifier,feature_vec')

end
%% 

clc
I = imread('C:\Users\Umang Shah\Documents\MATLAB\AeroFS\TestingFeatureBased\test90\36.jpg');
input_image = rgb2gray(imresize(I, [86,126]));
  input_image = im2double(input_image);
  % % calculate the similarity of the input to each training image
feature_vec = evectors' * (input_image(:) - mean_face);
matched = predict(classifier,feature_vec')
% similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images)
%  
% % find the image with the highest similarity
% [match_score, match_ix] = max(similarity_score);
%  
% % display the result
% figure, imshow([input_image reshape(images(:,match_ix), image_dims)]);
% title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));