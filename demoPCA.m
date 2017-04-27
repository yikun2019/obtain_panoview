%% Initialization
clear ; close all; clc

fprintf('this code will load 12 images and do PCA for each face.\n');
fprintf('10 images are used to train PCA and the other 2 images are used to test PCA.\n');

m = 4000; % number of samples
trainset = zeros(m, 32 * 32); % image size is : 32 * 32

for i = 1 : m
	img = imread(strcat('./img/', int2str(i), '.bmp'));
	img = double(img);
	trainset(i, :) = img(:);
end


%% before training PCA, do feature normalization
mu = mean(trainset);
trainset_norm = bsxfun(@minus, trainset, mu);

sigma = std(trainset_norm);
trainset_norm = bsxfun(@rdivide, trainset_norm, sigma);

%% we could save the mean face mu to take a look the mean face
imwrite(uint8(reshape(mu, 32, 32)), 'meanface.bmp');
fprintf('mean face saved. paused\n');
pause;

%% compute reduce matrix
X = trainset_norm; % just for convience
[m, n] = size(X);

U = zeros(n);
S = zeros(n);

Cov = 1 / m * X' * X;
[U, S, V] = svd(Cov);
fprintf('compute cov done.\n');

%% save eigen face
for i = 1:10
	ef = U(:, i)';
	img = ef;
	minVal = min(img);
	img = img - minVal;
	max_val = max(abs(img));
	img = img / max_val;
	img = reshape(img, 32, 32);
	imwrite(img, strcat('eigenface', int2str(i), '.bmp'));
end

fprintf('eigen face saved, paused.\n');
pause;

%% dimension reduction
k = 100; % reduce to 100 dimension
test = zeros(10, 32 * 32);
for i = 4001:4010
	img = imread(strcat('./img/', int2str(i), '.bmp'));
	img = double(img);
	test(i - 4000, :) = img(:);
end

% test set need to do normalization
test = bsxfun(@minus, test, mu);

% reduction
Uk = U(:, 1:k);
Z = test * Uk;
fprintf('reduce done.\n');

%% reconstruction
%% for the test set images, we only minus the mean face,
% so in the reconstruct process, we need add the mean face back
Xp = Z * Uk';
% show reconstructed face
for i = 1:5
	face = Xp(i, :) + mu;
	face = reshape((face), 32, 32);
	imwrite(uint8(face), strcat('./reconstruct/', int2str(4000 + i), '.bmp'));
end

%% for the train set reconstruction, we minus the mean face and divide by standard deviation during the train
% so in the reconstruction process, we need to multiby standard deviation first, 
% and then add the mean face back
trainset_re = trainset_norm * Uk; % reduction
trainset_re = trainset_re * Uk'; % reconstruction
for i = 1:5
	train = trainset_re(i, :);
	train = train .* sigma;
	train = train + mu;
	train = reshape(train, 32, 32);
	imwrite(uint8(train), strcat('./reconstruct/', int2str(i), 'train.bmp'));
end

fprintf('job done.\n');