%load data
behav_analyzer;

figure(1)
A = p2_t_O.';
B = p2_i_O.';
C = p2_d_O.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p1,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');

figure(2)
A = p2_t_V.';
B = p2_i_V.';
C = p2_d_V.';
y = cat(2, A, B,C);
group = {'t','i','d'}; 
[p2,~,stats] = anova1(y,group,'off');
[results,means] = multcompare(stats,'CType','bonferroni');


