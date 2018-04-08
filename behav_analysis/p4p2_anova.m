%load data
behav_analyzer;

figure(1)
A = O_diffs_t.';
B = O_diffs_i.';
C = O_diffs_d.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p1,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');

figure(2)
A = V_diffs_t.';
B = V_diffs_i.';
C = V_diffs_d.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p2,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');

%% t test for t vs. d and i vs. d

x3 = V_diffs_t; 
y3 = V_diffs_d; 
[h3,p3] = ttest(x3,y3); 

x4 = V_diffs_i; 
y4 = V_diffs_d; 
[h4,p4] = ttest(x4,y4); 

x5 = V_diffs_t; 
y5 = V_diffs_i; 
[h5,p5] = ttest(x5,y5); 
