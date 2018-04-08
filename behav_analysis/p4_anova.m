%load data
behav_analyzer;

figure(1)
A = p4_t_O.';
B = p4_i_O.';
C = p4_d_O.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p1,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');

figure(2)
A = p4_t_V.';
B = p4_i_V.';
C = p4_d_V.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p2,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');

%% t test for t vs. d and i vs. d

x3 = p4_t_V; 
y3 = p4_d_V; 
[h3,p3] = ttest(x3,y3); 

x4 = p4_i_V; 
y4 = p4_d_V; 
[h4,p4] = ttest(x4,y4); 

x5 = p4_t_V; 
y5 = p4_i_V; 
[h5,p5] = ttest(x5,y5); 




