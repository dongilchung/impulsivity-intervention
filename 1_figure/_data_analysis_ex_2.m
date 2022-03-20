clc
clear all
close all
addpath('Function')
load('0_Data/accumData_Ex2.mat')

%% Figure 2 

WMlogKPre = Dat.logK.Pre{3};
% WMlogKPre(13) = [];
WMlogKPost = Dat.logK.Post{3};
% WMlogKPost(13) = [];

logk_pre_total = [Dat.logK.Pre{1};Dat.logK.Pre{2};WMlogKPre;Dat.logK.Pre{4};Dat.logK.Pre{5}];
logk_post_total = [Dat.logK.Post{1};Dat.logK.Post{2};WMlogKPost;Dat.logK.Post{4};Dat.logK.Post{5}];

logk_pre_135 = [Dat.logK.Pre{1};WMlogKPre;Dat.logK.Pre{5}];
logk_post_135 = [Dat.logK.Post{1};WMlogKPost;Dat.logK.Post{5}];

%%% top
idx4 = 1;
idx3 = 3;
idx2 = 1;
figure,
hold on
for idx1 = 1:length(logk_pre_total)
    if idx3 ==3
        pre_data    = WMlogKPre;
        post_data   = WMlogKPost;
    else
        pre_data    = Dat.logK.Pre{idx3};
        post_data   = Dat.logK.Post{idx3};
    end
    if pre_data(idx2)>post_data(idx2)
        plot([idx4,idx4+1],[pre_data(idx2),post_data(idx2)],'r.-','markersize',30,'linewidth',1.5);
    else
        plot([idx4,idx4+1],[pre_data(idx2),post_data(idx2)],'b.-','markersize',30,'linewidth',1.5);
    end
    breaker = length(Dat.logK.Pre{idx3});
    if idx3 ==3
        breaker = length(WMlogKPre);
    end
    if idx2 == breaker 
        idx3 = idx3 +1;
        idx4 = idx4 +2;
        idx2 = 0;
    end
    idx2 = idx2 + 1;
end
xlim([0,7])
set(gca,'LineWidth',2.0)
xticks([1:6]), xticklabels({'Task3-Pre','Task3-Post','Task4-Pre','Task4-Post','Task5-Pre','Task5-Post'})

%%% bottom
figure
hold on
idx = 1;
for idx1 = 3:1:length(Dat.logK.Pre)
    if idx1 ==3
        pre_data    = WMlogKPre;
        post_data   = WMlogKPost;
    else
        pre_data    = Dat.logK.Pre{idx1};
        post_data   = Dat.logK.Post{idx1};
    end
    errorbar([idx,idx+1],[mean(pre_data),mean(post_data)],[std(pre_data)/sqrt(length(pre_data)),std(post_data)/sqrt(length(post_data))],'k.-','markersize',30,'linewidth',1.5);
    idx = idx+2;
end
xlim([0,7])
set(gca,'LineWidth',2.0)
xticks([1:6]), xticklabels({'Task3-Pre','Task3-Post','Task4-Pre','Task4-Post','Task5-Pre','Task5-Post'})

%% Figure 3a
% Working memory
% window time
% window performance mean

Time        = Dat.Window.Time{1};
MeanPoint   = Dat.Window.Avg{1};
Sde         = Dat.Window.Sde{1};

%%% plot
stats = regstats(MeanPoint,Time');
b = stats.tstat.beta;

figure, errorbar(Time', MeanPoint,Sde,'k.','MarkerSize',60,'linewidth',1), hold on; box off, plot([min(Time) max(Time)],b(1)+b(2)*[min(Time) max(Time)],'r','LineWidth',2.0)
xlabel('time'), ylabel('score')
set(gca,'LineWidth',2.0)
xticks([1:5:length(Time)])

%%% correlation (r,p,r^2)
[r,p] = corr(Time',MeanPoint,'type','pearson') % significant /0.4983 /0.0017 /0.2483
r^2

%% Figure 3b
% Working memory
% log k change
% Accuracy

logk = Dat.logK.Pre{3} - Dat.logK.Post{3};
Performance = Dat.Accuracy{3};
% 
% logk(17) = [];
% Performance(17) = [];

%%% plot
stats = regstats(logk,Performance);
b = stats.tstat.beta;

figure
plot(Performance,logk,'k.','MarkerSize',60); hold on; box off, plot([min(Performance) max(Performance)],b(1)+b(2)*[min(Performance) max(Performance)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Performance) max(Performance)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Performance,logk,'type','pearson') % not significant /-0.1827 /0.3821 /0.0334
r^2
 
% [r,p] = corr(Performance(Performance>0.9),logk(Performance>0.9),'type','pearson') % not significant /0.3157 /0.1633 /0.0997
% r^2

%% Figure 3c
% Working memory
% log k change
% Performance slope

logk = Dat.logK.Pre{3} - Dat.logK.Post{3};
Slope = Dat.Slope{1};

%%% plot
stats = regstats(logk,Slope);
b = stats.tstat.beta;

figure
plot(Slope,logk,'k.','MarkerSize',60); hold on; box off, plot([min(Slope) max(Slope)],b(1)+b(2)*[min(Slope) max(Slope)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Slope) max(Slope)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Slope,logk,'type','pearson') % not significant /-0.1936/0.3537 /0.0375
r^2

%% Figure 3d
% Working memory
% time bin accuracy
% log k change

TimeBinScore = Dat.TimeBinScore{1};
% TimeBinScore(13,:) = [];

logk = Dat.logK.Pre{3}-Dat.logK.Post{3};
% logk(13) = [];

cc = zeros(5,1);
p  = zeros(5,1);
%%% plot
[cc(1:3),p(1:3)] = corr(TimeBinScore(:,1:3),logk, 'type', 'pearson');
% not significant
% not significant
[cc(4:5),p(4:5)] = corr(TimeBinScore(:,4:5),logk, 'type', 'spearman');
% marginal/ -0.3845/ 0.0578
% not significant/ -0.3075/ 0.1348

figure
bar([1,2,3,4,5],cc,'k'),box off, xlabel('time'), ylabel('r')
set(gca,'LineWidth',2.0)

%% Figure S2a
WMDPre = Dat.DelayedOptionRatio.Pre{3};
% WMDPre(13) = [];
WMDPost = Dat.DelayedOptionRatio.Post{3};
% WMDPost(13) = [];

DelayedOptionRatio_pre_total = [Dat.DelayedOptionRatio.Pre{1};Dat.DelayedOptionRatio.Pre{2};WMDPre;Dat.DelayedOptionRatio.Pre{4};Dat.DelayedOptionRatio.Pre{5}];
DelayedOptionRatio_post_total = [Dat.DelayedOptionRatio.Post{1};Dat.DelayedOptionRatio.Post{2};WMDPost;Dat.DelayedOptionRatio.Post{4};Dat.DelayedOptionRatio.Post{5}];

DelayedOptionRatio_pre_135 = [Dat.DelayedOptionRatio.Pre{1};Dat.DelayedOptionRatio.Pre{3};Dat.DelayedOptionRatio.Pre{5}];
DelayedOptionRatio_post_135 = [Dat.DelayedOptionRatio.Post{1};Dat.DelayedOptionRatio.Post{3};Dat.DelayedOptionRatio.Post{5}];

%%% top
idx4 = 1;
idx3 = 3;
idx2 = 1;
figure,
hold on
for idx1 = 1:length(DelayedOptionRatio_pre_total)
    pre_data    = 1-Dat.DelayedOptionRatio.Pre{idx3};
    post_data   = 1-Dat.DelayedOptionRatio.Post{idx3};
    if pre_data(idx2)>post_data(idx2)
        plot([idx4,idx4+1],[pre_data(idx2),post_data(idx2)],'r.-','markersize',30,'linewidth',1.5);
    else
        plot([idx4,idx4+1],[pre_data(idx2),post_data(idx2)],'b.-','markersize',30,'linewidth',1.5);
    end
    
    if idx2 == length(Dat.DelayedOptionRatio.Pre{idx3})
        idx4 = idx4 +2;
        idx3 = idx3 +1;
        idx2 = 0;
    end
    idx2 = idx2 + 1;
end
xlim([0,7])
set(gca,'LineWidth',2.0)

%%% bottom
figure
hold on
idx = 1;
for idx1 = 3:1:length(Dat.DelayedOptionRatio.Pre)
    pre_data    = 1-Dat.DelayedOptionRatio.Pre{idx1};
    post_data   = 1-Dat.DelayedOptionRatio.Post{idx1};

    errorbar([idx,idx+1],[mean(pre_data),mean(post_data)],[std(pre_data)/sqrt(length(pre_data)),std(post_data)/sqrt(length(post_data))],'k.-','markersize',30,'linewidth',1.5);
    idx = idx+2;
end
xlim([0,7])
set(gca,'LineWidth',2.0)

%% Figure S2b

stats = regstats(1-DelayedOptionRatio_pre_total,1-DelayedOptionRatio_post_total);
b = stats.tstat.beta;

%%% plot
figure
plot(1-DelayedOptionRatio_pre_total,1-DelayedOptionRatio_post_total,'k.','MarkerSize',60); hold on; box off, plot([min(DelayedOptionRatio_pre_total) max(DelayedOptionRatio_pre_total)],b(1)+b(2)*[min(DelayedOptionRatio_pre_total) max(DelayedOptionRatio_pre_total)],'r','LineWidth',2.0)%,plot([min(logD_pre_total),max(logD_pre_total)],[0,0],'k--','linewidth',1.2)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(1-DelayedOptionRatio_pre_total,1-DelayedOptionRatio_post_total,'type','Pearson') % significant /0.9430 /3.2345e-34 /0.8893
r^2

%% Figure S2c

stats = regstats(logk_pre_total,logk_post_total);
b = stats.tstat.beta;

%%% plot
figure
plot(logk_pre_total,logk_post_total,'k.','MarkerSize',60); hold on; box off, plot([min(logk_pre_total) max(logk_pre_total)],b(1)+b(2)*[min(logk_pre_total) max(logk_pre_total)],'r','LineWidth',2.0)%,plot([min(logD_pre_total),max(logD_pre_total)],[0,0],'k--','linewidth',1.2)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(logk_pre_total,logk_post_total,'type','Pearson') % significant /0.9313 /1.5529e-31 /0.8673
r^2

%% Figure S3c
% Working memory
%%% top
% Accuracy
% Delayed Option ratio

DelayedOptrionRatio = -Dat.DelayedOptionRatio.Pre{3} + Dat.DelayedOptionRatio.Post{3};
Performance = Dat.Accuracy{3};

%%% plot
stats = regstats(DelayedOptrionRatio,Performance);
b = stats.tstat.beta;

figure
plot(Performance,DelayedOptrionRatio,'k.','MarkerSize',60); hold on; box off, plot([min(Performance) max(Performance)],b(1)+b(2)*[min(Performance) max(Performance)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Performance) max(Performance)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Performance,DelayedOptrionRatio,'type','pearson') % not significant 
r^2

%%% bottom
% Accuracy
% logk

logk = Dat.logK.Pre{3} - Dat.logK.Post{3};
Performance = Dat.Accuracy{3};

%%% plot
stats = regstats(logk,Performance);
b = stats.tstat.beta;

figure
plot(Performance,logk,'k.','MarkerSize',60); hold on; box off, plot([min(Performance) max(Performance)],b(1)+b(2)*[min(Performance) max(Performance)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Performance) max(Performance)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Performance,logk,'type','pearson') % not significant
r^2

%% Figure S3d
% Control WM
%%% top
% Accuracy
% Delayed Option ratio

DelayedOptrionRatio = -Dat.DelayedOptionRatio.Pre{4} + Dat.DelayedOptionRatio.Post{4};
Performance = Dat.Accuracy{4};

%%% plot
stats = regstats(DelayedOptrionRatio,Performance);
b = stats.tstat.beta;

figure
plot(Performance,DelayedOptrionRatio,'k.','MarkerSize',60); hold on; box off, plot([min(Performance) max(Performance)],b(1)+b(2)*[min(Performance) max(Performance)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Performance) max(Performance)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Performance,DelayedOptrionRatio,'type','pearson') % not significant 
r^2

%%% bottom
% Accuracy
% logk

logk = Dat.logK.Pre{4} - Dat.logK.Post{4};
Performance = Dat.Accuracy{4};

%%% plot
stats = regstats(logk,Performance);
b = stats.tstat.beta;

figure
plot(Performance,logk,'k.','MarkerSize',60); hold on; box off, plot([min(Performance) max(Performance)],b(1)+b(2)*[min(Performance) max(Performance)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Performance) max(Performance)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Performance,logk,'type','pearson') % not significant
r^2

%% Figure S4a
% Working memory
% window time
% window performance mean

Time        = Dat.Window.Time{1};
MeanPoint   = Dat.Window.Avg{1};
Sde         = Dat.Window.Sde{1};

%%% plot
stats = regstats(MeanPoint,Time');
b = stats.tstat.beta;

figure, errorbar(Time', MeanPoint,Sde,'k.','MarkerSize',60,'linewidth',1), hold on; box off, plot([min(Time) max(Time)],b(1)+b(2)*[min(Time) max(Time)],'r','LineWidth',2.0)
xlabel('time'), ylabel('score')
set(gca,'LineWidth',2.0)
xticks([1:5:length(Time)])

%%% correlation (r,p,r^2)
[r,p] = corr(Time',MeanPoint,'type','pearson') % significant /0.4983 /0.0017 /0.2483
r^2

%% Figure S4b
% Working memory
% delayed option ratio
% Performance slope

DelayedOptrionRatio = -Dat.DelayedOptionRatio.Pre{3} + Dat.DelayedOptionRatio.Post{3};
Slope = Dat.Slope{1};

%%% plot
stats = regstats(DelayedOptrionRatio,Slope);
b = stats.tstat.beta;

figure
plot(Slope,DelayedOptrionRatio,'k.','MarkerSize',60); hold on; box off, plot([min(Slope) max(Slope)],b(1)+b(2)*[min(Slope) max(Slope)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(Slope) max(Slope)],[0,0],'k--','LineWidth',1.3)
set(gca,'LineWidth',2.0)

%%% correlation (r,p,r^2)
[r,p] = corr(Slope,DelayedOptrionRatio,'type','pearson') % not significant
r^2

%% Figure S4c
% Working memory
% time bin accuracy
% delayed option ratio change

TimeBinScore = Dat.TimeBinScore{1};

DelayedOptrionRatio = Dat.DelayedOptionRatio.Post{3} - Dat.DelayedOptionRatio.Pre{3};

cc = zeros(5,1);
%%% plot
[cc(1:3),p] = corr(TimeBinScore(:,1:3),DelayedOptrionRatio, 'type', 'pearson');
[cc(4:5),p] = corr(TimeBinScore(:,4:5),DelayedOptrionRatio, 'type', 'spearman');

figure
bar([1,2,3,4,5],cc,'k'),box off, xlabel('time'), ylabel('r')
set(gca,'LineWidth',2.0)

%% Figure S4d
% Control WM
% window time
% window performance mean

Time        = Dat.Window.Time{2};
MeanPoint   = Dat.Window.Avg{2};
Sde         = Dat.Window.Sde{2};

%%% plot
stats = regstats(MeanPoint,Time');
b = stats.tstat.beta;

figure, errorbar(Time', MeanPoint,Sde,'k.','MarkerSize',60,'linewidth',1), hold on; box off, plot([min(Time) max(Time)],b(1)+b(2)*[min(Time) max(Time)],'color',[.5 .5 .5],'LineWidth',2.0)
xlabel('time'), ylabel('score')
set(gca,'LineWidth',2.0)
xticks([1:5:length(Time)])

%%% correlation (r,p,r^2)
[r,p] = corr(Time',MeanPoint,'type','pearson') % not significant /0.1851 /0.0880 /0.0343
r^2

%% Figure S4e
%%% top
% Control WM
% performance slope
% dleayed option ratio

IsOutlier = logical(Dat.Outlier.ControlWM);

PerformanceSlope = Dat.Slope{2};
PerformanceSlope(IsOutlier) = [];
d = -Dat.DelayedOptionRatio.Pre{4}+Dat.DelayedOptionRatio.Post{4};
d(IsOutlier) = [];

b=robustfit(PerformanceSlope,d)
figure,
plot(PerformanceSlope,d,'k.','MarkerSize',60); hold on; box off, plot([min(PerformanceSlope) max(PerformanceSlope)],b(1)+b(2)*[min(PerformanceSlope) max(PerformanceSlope)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(PerformanceSlope) max(PerformanceSlope)],[0,0],'k--','LineWidth',1.3)
[r,p] = corr(PerformanceSlope,d,'type','spearman') % not significant, -0.1436, 0.4935
set(gca,'LineWidth',2.0)

%%% bottom
% Control WM
% performance slope
% log k change

IsOutlier = logical(Dat.Outlier.ControlWM);

PerformanceSlope = Dat.Slope{2};
PerformanceSlope(IsOutlier) = [];
logk = Dat.logK.Pre{4}-Dat.logK.Post{4};
logk(IsOutlier) = [];

b=robustfit(PerformanceSlope,logk)
figure,
plot(PerformanceSlope,logk,'k.','MarkerSize',60); hold on; box off, plot([min(PerformanceSlope) max(PerformanceSlope)],b(1)+b(2)*[min(PerformanceSlope) max(PerformanceSlope)],'color',[.5 .5 .5],'LineWidth',2.0), plot([min(PerformanceSlope) max(PerformanceSlope)],[0,0],'k--','LineWidth',1.3)
[r,p] = corr(PerformanceSlope,logk,'type','pearson') % not significant, -0.2198, 0.2910
set(gca,'LineWidth',2.0)

%% Figure S4f 
%%% top
% Control WM
% time bin accuracy
% delayed option ratio

IsOutlier = logical(Dat.Outlier.ControlWM);

TimeBinScore = Dat.TimeBinScore{2};
TimeBinScore(IsOutlier,:) = [];
d = -Dat.DelayedOptionRatio.Pre{4}+Dat.DelayedOptionRatio.Post{4};
d(IsOutlier) = [];

cc = zeros(5,1);
p = zeros(5,1);

[cc,p] = corr(TimeBinScore(:,1:3),d, 'type', 'pearson');
cc.^2
[cc(4),p(4)] = corr(TimeBinScore(:,4),d, 'type', 'spearman');
cc.^2
[cc(5),p(5)] = corr(TimeBinScore(:,4),d, 'type', 'pearson');
cc.^2
% r : 0.5731, 0.5083, 0.0234, -0.0263, 0.1497
% p : 0.0255, 0.0530. 0.9340, 0.9259, 0.5943
% r2: 0.3285, 0.2584, 0.0005, 0.0007, 0.0224
figure
bar([1,2,3,4,5],cc,'k'),box off, xlabel('time'), ylabel('r')
set(gca,'LineWidth',2.0)

%%% bottom
% Control WM
% time bin accuracy
% log k change

IsOutlier = logical(Dat.Outlier.ControlWM);

TimeBinScore = Dat.TimeBinScore{2};
TimeBinScore(IsOutlier,:) = [];

logk = Dat.logK.Pre{4}-Dat.logK.Post{4};
logk(IsOutlier) = [];

cc = zeros(5,1);
p = zeros(5,1);

[cc,p] = corr(TimeBinScore(:,1:3),logk, 'type', 'pearson');
cc.^2
[cc(4),p(4)] = corr(TimeBinScore(:,4),logk, 'type', 'spearman');
cc.^2
[cc(5),p(5)] = corr(TimeBinScore(:,4),logk, 'type', 'pearson');
cc.^2
% r : 0.3991, 0.4573, 0.2050, 0.2312, -0.0852
% p : 0.1406, 0.0866, 0.4636, 0.4070, 0.7629
% r2: 0.1593, 0.2091, 0.0420, 0.0535, 0.0073

figure
bar([1,2,3,4,5],cc,'k'),box off, xlabel('time'), ylabel('r')
set(gca,'LineWidth',2.0)