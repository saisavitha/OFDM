% MIMO ANALYSIS PLOTTING TOOL
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CASE 1: 2X1

MIMO_NUM_RX_ANT_SET = 1;

MIMO_NUM_TX_ANT_SET=2;

filevar = ['Eb_N0_dB'; 'maxEb   '; 'Ber     '; 'Ber4    '; 'Ber16   '; 'Ber64   '];

sizeX = 1400;

sizeY = 700;

figure('Position',[100 700-sizeY sizeX sizeY]);

set(gcf,'defaultaxesfontsize',14); 

filename = ['PI_MIMOLOGDAT_' num2str(MIMO_NUM_TX_ANT_SET) 'x' num2str(MIMO_NUM_RX_ANT_SET) ];



% BER PLOT FOR 64QAM
load([filename '-Ber64.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber64(1:maxEb),'k^-.','LineWidth',2, 'MarkerSize',5);

hold on;

grid on


hold on;

grid on

h_legend = legend( ' 64-QAM', 'Location','Best');


set(h_legend,'FontSize',12);

xlabel('SNR (dB)','FontSize',12);

ylabel('Bit Error Rate (BER)','FontSize',12);

title('BER FOR QAM 64','FontSize',12);

