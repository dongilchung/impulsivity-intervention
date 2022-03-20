function [t_data, p_data] = ccbootsrappingttest(group1,group2, bootlength) 
%%% non parametric ttest
%%% 2020 04 23

pool = [group1; group2];

fprintf('Bootstrapping start\n')
t_data = [];
p_data = [];
for idx = 1:bootlength
    
    idx1 = randi([1,length(pool)],[1,length(group1)]);
    idx2 = randi([1,length(pool)],[1,length(group2)]);
    x = pool(idx1);
    y = pool(idx2);
    
    [h,p,ci,stats] = ttest(x,y);
        
    t_data = [t_data; stats.tstat];
    p_data = [p_data; p];
    fprintf('.\n')
end

fprintf('Loop end.\n')