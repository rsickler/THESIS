% COMPARES VARIOUS CLASSIFIER ACCURACIES ACROSS ALL 3 MASKS

%load in accuracies
go_go_MI = [0.79	0.68	0.56	0.70]; 
go_go_SM = [0.61	0.59	0.38	0.59];
go_go_AM = [0.51	0.38	0.33	0.39];
go_go_PM = [0.84	0.70	0.53	0.70]; 
go_go_PS = [0.86	0.68	0.59	0.76];
go_go_MP = [0.43	0.62	0.38	0.45];
go_go_WB = [0.78	0.72	0.55	0.68];
mean_go_go_MI = mean(go_go_MI);
mean_go_go_SM = mean(go_go_SM);
mean_go_go_AM = mean(go_go_AM); 
mean_go_go_PM = mean(go_go_PM);
mean_go_go_PS = mean(go_go_PS);
mean_go_go_MP = mean(go_go_MP); 
mean_go_go_WB = mean(go_go_WB); 
stderror_go_go_MI = std(go_go_MI) / sqrt(length(go_go_MI));
stderror_go_go_SM = std(go_go_SM) / sqrt(length(go_go_SM));
stderror_go_go_AM = std(go_go_AM) / sqrt(length(go_go_AM));
stderror_go_go_PM = std(go_go_PM) / sqrt(length(go_go_PM));
stderror_go_go_PS = std(go_go_PS) / sqrt(length(go_go_PS));
stderror_go_go_MP = std(go_go_MP) / sqrt(length(go_go_MP));
stderror_go_go_WB = std(go_go_WB) / sqrt(length(go_go_WB));

% test to see if different
%[h,p] = ttest(go_go_AM,.3333); 

%%
imag_imag_MI = [0.47	0.43	0.44	0.41]; 
imag_imag_SM = [0.40	0.34	0.48	0.35];
imag_imag_AM = [0.26	0.35	0.29	0.38];
imag_imag_PM = [0.41	0.41	0.43	0.48];
imag_imag_PS = [0.43	0.46	0.45	0.43];
imag_imag_MP = [0.39	0.41	0.30	0.33];
imag_imag_WB = [0.41	0.45	0.45	0.33];
mean_imag_imag_MI = mean(imag_imag_MI);
mean_imag_imag_SM = mean(imag_imag_SM);
mean_imag_imag_AM = mean(imag_imag_AM); 
mean_imag_imag_PM = mean(imag_imag_PM);
mean_imag_imag_PS = mean(imag_imag_PS);
mean_imag_imag_MP = mean(imag_imag_MP); 
mean_imag_imag_WB = mean(imag_imag_WB); 
stderror_imag_imag_MI = std(imag_imag_MI) / sqrt(length(imag_imag_MI));
stderror_imag_imag_SM = std(imag_imag_SM) / sqrt(length(imag_imag_SM));
stderror_imag_imag_AM = std(imag_imag_AM) / sqrt(length(imag_imag_AM));
stderror_imag_imag_PM = std(imag_imag_PM) / sqrt(length(imag_imag_PM));
stderror_imag_imag_PS = std(imag_imag_PS) / sqrt(length(imag_imag_PS));
stderror_imag_imag_MP = std(imag_imag_MP) / sqrt(length(imag_imag_MP));
stderror_imag_imag_WB = std(imag_imag_WB) / sqrt(length(imag_imag_WB));

% test to see if different
[h,p] = ttest(imag_imag_MI,0.33333); 

%%
go_imag_MI = [0.36	0.35	0.32	0.32]; 
go_imag_SM = [0.33	0.31	0.32	0.35];
go_imag_AM = [0.38	0.22	0.32	0.30];
go_imag_PM = [0.35	0.35	0.42	0.34];
go_imag_PS = [0.32	0.36	0.39	0.41];
go_imag_MP = [0.28	0.32	0.29	0.28];
go_imag_WB = [0.32	0.32	0.32	0.35];
mean_go_imag_MI = mean(go_imag_MI);
mean_go_imag_SM = mean(go_imag_SM);
mean_go_imag_AM = mean(go_imag_AM); 
mean_go_imag_PM = mean(go_imag_PM);
mean_go_imag_PS = mean(go_imag_PS);
mean_go_imag_MP = mean(go_imag_MP); 
mean_go_imag_WB = mean(go_imag_WB); 
stderror_go_imag_MI = std(go_imag_MI) / sqrt(length(go_imag_MI));
stderror_go_imag_SM = std(go_imag_SM) / sqrt(length(go_imag_SM));
stderror_go_imag_AM = std(go_imag_AM) / sqrt(length(go_imag_AM));
stderror_go_imag_PM = std(go_imag_PM) / sqrt(length(go_imag_PM));
stderror_go_imag_PS = std(go_imag_PS) / sqrt(length(go_imag_PS));
stderror_go_imag_MP = std(go_imag_MP) / sqrt(length(go_imag_MP));
stderror_go_imag_WB = std(go_imag_WB) / sqrt(length(go_imag_WB));

% test to see if different
[~,p1] = ttest(go_imag_MI,0.33333); 
[~,p2] = ttest(go_imag_SM,0.33333); 
[~,p3] = ttest(go_imag_AM,0.33333); 
[~,p4] = ttest(go_imag_PM,0.33333); 
[~,p5] = ttest(go_imag_PS,0.33333); 
[~,p6] = ttest(go_imag_MP,0.33333); 
[~,p7] = ttest(go_imag_WB,0.33333); 
P_go_imag = [p1 p2 p3 p4 p5 p6 p7];


%%
imag_go_MI = [0.42	0.44	0.30	0.29]; 
imag_go_SM = [0.32	0.34	0.38	0.24];
imag_go_AM = [0.29	0.26	0.38	0.27];
imag_go_PM = [0.38	0.40	0.43	0.30];
imag_go_PS = [0.32	0.41	0.44	0.36];
imag_go_MP = [0.38	0.35	0.32	0.34];
imag_go_WB = [0.42	0.43	0.40	0.30];
mean_imag_go_MI = mean(imag_go_MI);
mean_imag_go_SM = mean(imag_go_SM);
mean_imag_go_AM = mean(imag_go_AM); 
mean_imag_go_PM = mean(imag_go_PM);
mean_imag_go_PS = mean(imag_go_PS);
mean_imag_go_MP = mean(imag_go_MP); 
mean_imag_go_WB = mean(imag_go_WB); 
stderror_imag_go_MI = std(imag_go_MI) / sqrt(length(imag_go_MI));
stderror_imag_go_SM = std(imag_go_SM) / sqrt(length(imag_go_SM));
stderror_imag_go_AM = std(imag_go_AM) / sqrt(length(imag_go_AM));
stderror_imag_go_PM = std(imag_go_PM) / sqrt(length(imag_go_PM));
stderror_imag_go_PS = std(imag_go_PS) / sqrt(length(imag_go_PS));
stderror_imag_go_MP = std(imag_go_MP) / sqrt(length(imag_go_MP));
stderror_imag_go_WB = std(imag_go_WB) / sqrt(length(imag_go_WB));

[~,p1] = ttest(imag_go_MI,0.33333); 
[~,p2] = ttest(imag_go_SM,0.33333); 
[~,p3] = ttest(imag_go_AM,0.33333); 
[~,p4] = ttest(imag_go_PM,0.33333); 
[~,p5] = ttest(imag_go_PS,0.33333); 
[~,p6] = ttest(imag_go_MP,0.33333); 
[~,p7] = ttest(imag_go_WB,0.33333); 
P_go_imag = [p1 p2 p3 p4 p5 p6 p7];


%% make .text files for MRIcron event timing

go1_Sequence ={'BM','OL','OR','WR','OM','BL','GR','WM','GM','WL','BR','GL',...
    'BR','BM','BL','GM','OR','OL','OM','GR','WL','GL','WR','WM'};
imag1_Sequence = {'BM.jpg','WL.jpg','GM.jpg','OM.jpg','BL.jpg','GR.jpg',...
    'OL.jpg','WR.jpg','WM.jpg','BR.jpg','OR.jpg','GL.jpg','GL.jpg','WM.jpg',...
    'OR.jpg','OM.jpg','BL.jpg','BR.jpg','BM.jpg','WL.jpg','GM.jpg','WR.jpg','OL.jpg','GR.jpg'};

lefts = zeros(1,24);
middles = zeros(1,24);
rights = zeros(1,24);
for i = 1:length(go1_Sequence)
    if go1_Sequence{i}(2) == 'L'
        lefts(1,i) = 1; 
    elseif go1_Sequence{i}(2) == 'M'
        middles(1,i) = 1; 
    elseif go1_Sequence{i}(2) == 'R'
        rights(1,i) = 1; 
    end
end
L = find(lefts); 
M = find(middles); 
R = find(rights); 

first = 28; 
between_time = 26; 
trials = 24; 

LEFT = zeros(8,3);
LEFT(:,3) = 1;
LEFT(:,2) = 4;
for i = 1:8
    LEFT(i,1) = first + ((L(i)-1)* between_time);
end

MIDDLE = zeros(8,3);
MIDDLE(:,3) = 1;
MIDDLE(:,2) = 4;
for i = 1:8
    MIDDLE(i,1) = first + ((M(i)-1)* between_time);
end


RIGHT = zeros(8,3);
RIGHT(:,3) = 1;
RIGHT(:,2) = 4;
for i = 1:8
    RIGHT(i,1) = first + ((R(i)-1)* between_time);
end


