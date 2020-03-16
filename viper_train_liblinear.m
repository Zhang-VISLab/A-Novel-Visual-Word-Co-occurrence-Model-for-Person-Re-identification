% function viper_train_liblinear

load('files/VIPeR/train_test_setting.mat');

%%% train svms
x = sparse(zeros(Nf1*Nf2, size(train_pair_id,1)));
parfor i = 1:size(train_pair_id,1)
    tmp = dt_feat{1}{train_id(train_pair_id(i,1))}' * dt_feat{2}{train_id(train_pair_id(i,2))};
    x(:,i) = tmp(:); 
end
%     x = x./(im_size(1)*im_size(2));
%     x = x - repmat(mean(x,2), [1 size(x,2)]);
max_val = max(abs(x(:)));
x = x./max_val;

cmd = sprintf('-B 1 -c 0.025 -w1 %f', sum(train_pair_y==-1)/sum(train_pair_y==1));
model = train(train_pair_y, x', cmd);     

