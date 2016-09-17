clear all
input_dir = 'C:\Users\Umang Shah\Documents\MATLAB\FaceRec\train';
image_dims = [90, 90];
filenames = dir(fullfile(input_dir, '*.jpg'));
num_images = numel(filenames);
images = [];

for n = 1:num_images
   
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
%  figure, imshow(img);
    
    img = im2double(img);
    if n == 1
        images = zeros(prod(image_dims), num_images);
    end
    img = imresize(img,image_dims);
    images(:, n) = img(:);
%         images(:, n) = reshape(img(:),[],1);
end

mean_face = mean(images,2);
shifted_images = images - repmat(mean_face,1, num_images);

% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = princomp(images');

num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
 
% step 6: project the images into the subspace to generate the feature vectors
features = evectors' * shifted_images;


name = 'eigen2demo.mat'
save(name);
