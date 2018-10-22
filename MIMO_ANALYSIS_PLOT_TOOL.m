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

% BER PLOT FOR BPSK
load([filename '-Ber.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber(1:maxEb),':r>','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

% BER PLOT FOR QPSK
load([filename '-Ber4.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber4(1:maxEb),':g^','LineWidth',2, 'MarkerSize',5);

hold on;

grid on


% BER PLOT FOR 16QAM
load([filename '-Ber16.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber16(1:maxEb),':b^','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

% BER PLOT FOR 64QAM
load([filename '-Ber64.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber64(1:maxEb),'k^-.','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

h_legend = legend( '2x1, BPSK','2x1, QPSK','2x1, 16-QAM',  '2x1, 64-QAM', 'Location','Best');

% SET AXIS HERE
set(h_legend,'FontSize',12);

xlabel('SNR (dB)','FontSize',12);

ylabel('Bit Error Rate (BER)','FontSize',12);

title('BER of 2X1 MIMO FOR BPSK QPSK QAM16 AND QAM 64','FontSize',12);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CASE 2: 2X2

MIMO_NUM_RX_ANT_SET = 2;

MIMO_NUM_TX_ANT_SET=2;

filevar = ['Eb_N0_dB'; 'maxEb   '; 'Ber     '; 'Ber4    '; 'Ber16   '; 'Ber64   '];

sizeX = 1400;

sizeY = 700;

figure('Position',[100 700-sizeY sizeX sizeY]);

set(gcf,'defaultaxesfontsize',14); 

filename = ['PI_MIMOLOGDAT_' num2str(MIMO_NUM_TX_ANT_SET) 'x' num2str(MIMO_NUM_RX_ANT_SET) ];

% BER PLOT FOR BPSK
load([filename '-Ber.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber(1:maxEb),':r>','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

% BER PLOT FOR QPSK
load([filename '-Ber4.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber4(1:maxEb),':g^','LineWidth',2, 'MarkerSize',5);

hold on;

grid on


% BER PLOT FOR 16QAM
load([filename '-Ber16.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber16(1:maxEb),':b^','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

% BER PLOT FOR 64QAM
load([filename '-Ber64.mat']);

semilogy(Eb_N0_dB(1:maxEb),Ber64(1:maxEb),'k^-.','LineWidth',2, 'MarkerSize',5);

hold on;

grid on

h_legend = legend( '2x2, BPSK','2x2, QPSK','2x2, 16-QAM',  '2x2, 64-QAM', 'Location','Best');


set(h_legend,'FontSize',12);

xlabel('SNR (dB)','FontSize',12);

ylabel('Bit Error Rate (BER)','FontSize',12);

title('BER of 2X2 MIMO FOR BPSK QPSK QAM16 AND QAM 64','FontSize',12);

