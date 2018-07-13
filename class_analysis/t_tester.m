go_go_MI = [0.79	0.68	0.56	0.70]; 
go_go_SM = [0.61	0.59	0.38	0.59];
go_go_AM = [0.51	0.38	0.33	0.39];
go_go_PM = [0.84	0.70	0.53	0.70]; 
go_go_PS = [0.86	0.68	0.59	0.76];
go_go_MP = [0.43	0.62	0.38	0.45];
go_go_WB = [0.78	0.72	0.55	0.68];
imag_imag_MI = [0.47	0.43	0.44	0.41]; 
imag_imag_SM = [0.40	0.34	0.48	0.35];
imag_imag_AM = [0.26	0.35	0.29	0.38];
imag_imag_PM = [0.41	0.41	0.43	0.48];
imag_imag_PS = [0.43	0.46	0.45	0.43];
imag_imag_MP = [0.39	0.41	0.30	0.33];
imag_imag_WB = [0.41	0.45	0.45	0.33];
go_imag_MI = [0.36	0.35	0.32	0.32]; 
go_imag_SM = [0.33	0.31	0.32	0.35];
go_imag_AM = [0.38	0.22	0.32	0.30];
go_imag_PM = [0.35	0.35	0.42	0.34];
go_imag_PS = [0.32	0.36	0.39	0.41];
go_imag_MP = [0.28	0.32	0.29	0.28];
go_imag_WB = [0.32	0.32	0.32	0.35];
imag_go_MI = [0.42	0.44	0.30	0.29]; 
imag_go_SM = [0.32	0.34	0.38	0.24];
imag_go_AM = [0.29	0.26	0.38	0.27];
imag_go_PM = [0.38	0.40	0.43	0.30];
imag_go_PS = [0.32	0.41	0.44	0.36];
imag_go_MP = [0.38	0.35	0.32	0.34];
imag_go_WB = [0.42	0.43	0.40	0.30];

% test to see if "go go" significant
[~,p1] = ttest(go_go_MI,0.33333); 
[~,p2] = ttest(go_go_SM,0.33333); 
[~,p3] = ttest(go_go_AM,0.33333); 
[~,p4] = ttest(go_go_PM,0.33333); 
[~,p5] = ttest(go_go_PS,0.33333); 
[~,p6] = ttest(go_go_MP,0.33333); 
[~,p7] = ttest(go_go_WB,0.33333); 
P_go_go = [p1 p2 p3 p4 p5 p6 p7];

% test to see if "imag imag" significant
[~,p1] = ttest(imag_imag_MI,0.33333); 
[~,p2] = ttest(imag_imag_SM,0.33333); 
[~,p3] = ttest(imag_imag_AM,0.33333); 
[~,p4] = ttest(imag_imag_PM,0.33333); 
[~,p5] = ttest(imag_imag_PS,0.33333); 
[~,p6] = ttest(imag_imag_MP,0.33333); 
[~,p7] = ttest(imag_imag_WB,0.33333); 
P_imag_imag = [p1 p2 p3 p4 p5 p6 p7];

% test to see if "go imag" different
[~,p1] = ttest(go_imag_MI,0.33333); 
[~,p2] = ttest(go_imag_SM,0.33333); 
[~,p3] = ttest(go_imag_AM,0.33333); 
[~,p4] = ttest(go_imag_PM,0.33333); 
[~,p5] = ttest(go_imag_PS,0.33333); 
[~,p6] = ttest(go_imag_MP,0.33333); 
[~,p7] = ttest(go_imag_WB,0.33333); 
P_go_imag = [p1 p2 p3 p4 p5 p6 p7];

% test to see if "imag go" different
[~,p1] = ttest(imag_go_MI,0.33333); 
[~,p2] = ttest(imag_go_SM,0.33333); 
[~,p3] = ttest(imag_go_AM,0.33333); 
[~,p4] = ttest(imag_go_PM,0.33333); 
[~,p5] = ttest(imag_go_PS,0.33333); 
[~,p6] = ttest(imag_go_MP,0.33333); 
[~,p7] = ttest(imag_go_WB,0.33333); 
P_imag_go = [p1 p2 p3 p4 p5 p6 p7];

