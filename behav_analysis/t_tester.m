
%% load data
behav_analyzer;

%% t test for p2 A vs B (n=48) 
x48 = all_Ao; 
y48 = all_Bo; 
[h148,p148] = ttest(x48,y48); 

x248 = all_Av; 
y248 = all_Bv; 
[h248,p248] = ttest(x248,y248); 

%% t test for volley vs. non-volley

xv1 = v_Ao_ratio_t2; 
yv1 = nv_Ao_ratio_t2; 
[hv1,pv1] = ttest2(xv1,yv1);
xv2 = v_Bo_ratio_t2; 
yv2 = nv_Bo_ratio_t2; 
[hv2,pv2] = ttest2(xv2,yv2);
xv3 = v_Av_ratio_t2; 
yv3 = nv_Av_ratio_t2; 
[hv3,pv3] = ttest2(xv3,yv3);
xv4 = v_Bv_ratio_t2; 
yv4 = nv_Bv_ratio_t2; 
[hv4,pv4] = ttest2(xv4,yv4);

%% t test for p3 training group

x3 = p2_t_V; 
y3 = p3_t_V; 
[h3,p3] = ttest2(x3,y3)


