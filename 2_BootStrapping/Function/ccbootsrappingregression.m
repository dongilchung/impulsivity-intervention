function [r_data, p_data] = ccbootsrappingregression(group1,group2, bootlength) 
%%% non parametric ttest
%%% 2020 04 28

fprintf('Bootstrapping start\n')
r_data = [];
p_data = [];

for idx = 1:bootlength
    x = randi([1,length(group2)],[1,length(group2)]);
    y = randi([1,length(group1)],[1,length(group1)]);
    
    [r,p] = corr(group1(y), group2(x),'type','pearson');
    
    r_data = [r_data; r];
    p_data = [p_data; p];
    fprintf('.\n')
end

fprintf('Loop end.\n')