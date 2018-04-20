% COMPARES VARIOUS CLASSIFIER ACCURACIES ACROSS ALL 3 MASKS

%load in accuracies
go_go_MI = [0.79	0.68	0.56	0.70]; 
go_go_SM = [0.61	0.59	0.38	0.59];
go_go_AM = [0.51	0.38	0.33	0.39];
mean_go_go_MI = mean(go_go_MI);
mean_go_go_SM = mean(go_go_SM);
mean_go_go_AM = mean(go_go_AM); 
stderror_go_go_MI = std(go_go_MI) / sqrt(length(go_go_MI));
stderror_go_go_SM = std(go_go_SM) / sqrt(length(go_go_SM));
stderror_go_go_AM = std(go_go_AM) / sqrt(length(go_go_AM));

imag_imag_MI = [0.47	0.43	0.44	0.41]; 
imag_imag_SM = [0.40	0.34	0.48	0.35];
imag_imag_AM = [0.26	0.35	0.29	0.38];
mean_imag_imag_MI = mean(imag_imag_MI);
mean_imag_imag_SM = mean(imag_imag_SM);
mean_imag_imag_AM = mean(imag_imag_AM); 
stderror_imag_imag_MI = std(imag_imag_MI) / sqrt(length(imag_imag_MI));
stderror_imag_imag_SM = std(imag_imag_SM) / sqrt(length(imag_imag_SM));
stderror_imag_imag_AM = std(imag_imag_AM) / sqrt(length(imag_imag_AM));

go_imag_MI = [0.36	0.35	0.32	0.32]; 
go_imag_SM = [0.33	0.31	0.32	0.35];
go_imag_AM = [0.38	0.22	0.32	0.30];
mean_go_imag_MI = mean(go_imag_MI);
mean_go_imag_SM = mean(go_imag_SM);
mean_go_imag_AM = mean(go_imag_AM); 
stderror_go_imag_MI = std(go_imag_MI) / sqrt(length(go_imag_MI));
stderror_go_imag_SM = std(go_imag_SM) / sqrt(length(go_imag_SM));
stderror_go_imag_AM = std(go_imag_AM) / sqrt(length(go_imag_AM));

imag_go_MI = [0.42	0.44	0.30	0.29]; 
imag_go_SM = [0.32	0.34	0.38	0.24];
imag_go_AM = [0.29	0.26	0.38	0.27];
mean_imag_go_MI = mean(imag_go_MI);
mean_imag_go_SM = mean(imag_go_SM);
mean_imag_go_AM = mean(imag_go_AM); 
stderror_imag_go_MI = std(imag_go_MI) / sqrt(length(imag_go_MI));
stderror_imag_go_SM = std(imag_go_SM) / sqrt(length(imag_go_SM));
stderror_imag_go_AM = std(imag_go_AM) / sqrt(length(imag_go_AM));
