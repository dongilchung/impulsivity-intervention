%% Bootstrapping

clc
clear all
close all

addpath('Function')
load('0_Data/accumData_Ex1.mat')

%% 
%%% Associative memory
%%% accuracy
%%% log k

logk = Dat.logK.Pre{1} - Dat.logK.Post{1};
Performance = Dat.Accuracy{1};

[r,p] = corr(Performance,logk,'type','pearson') 

[r_data,p] = ccbootsrappingregression(Performance,logk,10000);
bootstrapping = sum(r_data>abs(r)|r_data<-abs(r))/length(r_data) % not significant /0.9391
h= hist(r_data,100);
figure, hist(r_data,100), hold on, plot([r,r],[0 max(h)],'r','Linewidth',1.5), plot([-r,-r],[0 max(h)],'r','Linewidth',1.5), box off
set(gca,'LineWidth',2.0)

%% 
%%% Control AM
%%% accuracy
%%% log k

logk = Dat.logK.Pre{2} - Dat.logK.Post{2};
Performance = Dat.Accuracy{2};

[r,p] = corr(Performance,logk,'type','pearson') 

[r_data,p] = ccbootsrappingregression(Performance,logk,10000);
bootstrapping = sum(r_data>abs(r)|r_data<-abs(r))/length(r_data) % not significant /0.7077
h= hist(r_data,100);
figure, hist(r_data,100), hold on, plot([r,r],[0 max(h)],'r','Linewidth',1.5), plot([-r,-r],[0 max(h)],'r','Linewidth',1.5), box off
set(gca,'LineWidth',2.0)
%% 
%%% Associative memory
%%% accuracy
%%% Delayed option latio

logk = Dat.logK.Pre{1} - Dat.logK.Post{1};
DelayedOptrionRatio = -Dat.DelayedOptionRatio.Pre{1} + Dat.DelayedOptionRatio.Post{1};

[r,p] = corr(Performance,logk,'type','pearson') 

[r_data,p] = ccbootsrappingregression(Performance,logk,10000);
bootstrapping = sum(r_data>abs(r)|r_data<-abs(r))/length(r_data) % not significant /0.9391
h= hist(r_data,100);
figure, hist(r_data,100), hold on, plot([r,r],[0 max(h)],'r','Linewidth',1.5), plot([-r,-r],[0 max(h)],'r','Linewidth',1.5), box off
set(gca,'LineWidth',2.0)

%% 
%%% Control AM
%%% accuracy
%%% Delayed option latio

logk = Dat.logK.Pre{2} - Dat.logK.Post{2};
Performance = Dat.Accuracy{2};

[r,p] = corr(Performance,logk,'type','pearson') 

[r_data,p] = ccbootsrappingregression(Performance,logk,10000);
bootstrapping = sum(r_data>abs(r)|r_data<-abs(r))/length(r_data) % not significant /0.7077
h= hist(r_data,100);
figure, hist(r_data,100), hold on, plot([r,r],[0 max(h)],'r','Linewidth',1.5), plot([-r,-r],[0 max(h)],'r','Linewidth',1.5), box off
set(gca,'LineWidth',2.0)