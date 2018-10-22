function MIMO_SIMULATION_COMPLETE_FLAG = MIMO_SIMULATION_BP_QP_16Q_64Q(MIMO_NUM_RX_ANT_SET,MIMO_NUM_TX_ANT_SET,SNR_SWEEP_MAX,SNR_SWEEP_MIN,VALIDATE_SAVERESULTS)


MIMO_SIMULATION_COMPLETE_FLAG=0;

if(VALIDATE_SAVERESULTS)
    MIMO_NUM_TX_ANT_SET = 2; 
else
    MIMO_NUM_TX_ANT_SET = MIMO_NUM_RX_ANT_SET;
end

filename = ['PI_MIMOLOGDAT_' num2str(MIMO_NUM_TX_ANT_SET) 'x' num2str(MIMO_NUM_RX_ANT_SET) ];
filevar = ['Eb_N0_dB'; 'maxEb   '; 'Ber     '; 'Ber4    '; 'Ber16   '; 'Ber64   '];

MIMO_MOD_BPSK_PARAM_SET = bin2dec(['0';'1']);

MIMO_MOD_QPSK_PARAM_SET = bin2dec(['01'; '11'; '00'; '10']);

MIMO_MOD_QAM_16_PARAM_SET = bin2dec(['1011'; '1001'; '0001'; '0011'; '1010'; '1000'; '0000'; '0010';
    '1110'; '1100'; '0100'; '0110'; '1111'; '1101'; '0101'; '0111']);

MIMO_MOD_QAM_64_PARAM_SET = bin2dec(['101100'; '101110'; '100110'; '100100'; '000100'; '000110';
    '001110'; '001100'; '101101'; '101111'; '100111'; '100101'; '000101';
    '000111'; '001111'; '001101'; '101001'; '101011'; '100011'; '100001';
    '000001'; '000011'; '001011'; '001001'; '101000'; '101010'; '100010';
    '100000'; '000000'; '000010'; '001010'; '001000'; '111000'; '111010';
    '110010'; '110000'; '010000'; '010010'; '011010'; '011000'; '111001';
    '111011'; '110011'; '110001'; '010001'; '010011'; '011011'; '011001';
    '111101'; '111111'; '110111'; '110101'; '010101'; '010111'; '011111';
    '011101'; '111100'; '111110'; '110110'; '110100'; '010100'; '010110';
    '011110'; '011100']);



MIMO_PARAM_NUM_SYMBOL_SET=10^4;

Eb_N0_dB = SNR_SWEEP_MIN:SNR_SWEEP_MAX; 

MIMO_PARAM_ZF_MMSE_MAX_SET = 100; 

MIMO_PARAM_MAX_SWP_SET=10000; 


mimo_param_qam_val = 4;

mimo_param_bit_per_symb=0; 

mimo_param_k_QAM_val=0; 

mimo_param_chnl_REAL_CONT=[]; 

mimo_param_chnl_IMG_CONT=[]; 

mimo_param_chnl_sqrt_MDATA = 0; 

mimo_param_tx_scale_fact = -1; 

MIMO_PARAM_BERR_CONT=zeros(1,length(Eb_N0_dB)); 

MIMO_PARAM_SYMERR_CONT=zeros(1,length(Eb_N0_dB)); 

maxEb = length(Eb_N0_dB); 

mimo_PARAM_index_hldr =[]; 

mimo_PARAM_ctnt_val_hldr = []; 

MIMO_PARAM_ZF_MAT_VAL = []; 

mimo_num_Tx_set = 2; 

mimo_num_Tx_symbl_set = 2; 

mimo_chnl_sprt_BW = mimo_num_Tx_symbl_set/mimo_num_Tx_set; 


while(mod(MIMO_PARAM_NUM_SYMBOL_SET,mimo_num_Tx_symbl_set))
    
    MIMO_PARAM_NUM_SYMBOL_SET=MIMO_PARAM_NUM_SYMBOL_SET+1;
    
end

for mimo_mod_cntrl_param_varble=1:4 
    
    
    if(mimo_mod_cntrl_param_varble==1)
        
        mimo_param_qam_val = 2;
        
    elseif(mimo_mod_cntrl_param_varble==2)
        
        mimo_param_qam_val = 4;
        
    elseif(mimo_mod_cntrl_param_varble==3)
        
        mimo_param_qam_val = 16;
        
    elseif(mimo_mod_cntrl_param_varble==4)
        
        mimo_param_qam_val = 64;
        
    end
    
    if(mimo_mod_cntrl_param_varble>1)
      
        QAMIQ = zeros(mimo_param_qam_val,1);
        
        mimo_param_chnl_sqrt_MDATA = sqrt(mimo_param_qam_val);
        
        mimo_param_bit_per_symb = log2(mimo_param_qam_val); 
        
        xmin = -mimo_param_chnl_sqrt_MDATA + 1;
        
        xmax = mimo_param_chnl_sqrt_MDATA - 1;
        
        ymin = -mimo_param_chnl_sqrt_MDATA + 1;
        
        ymax = mimo_param_chnl_sqrt_MDATA - 1;
        
        mimo_param_chnl_REAL_CONT = xmin:2:xmax
        
        mimo_param_chnl_IMG_CONT = ymin:2:ymax;
        
       
        
        mimo_par_lp_cntrl=1;
        
        for y = mimo_param_chnl_IMG_CONT
            
            for x = mimo_param_chnl_REAL_CONT
                
                QAMIQ(mimo_par_lp_cntrl)= x+y*1i;
                
                mimo_par_lp_cntrl = mimo_par_lp_cntrl+1;
                
            end
        end
        
        
        
        MIMO_PARAM_ZF_MAT_VAL = MIMO_PARAM_TER_PROD(QAMIQ,ones(1,MIMO_PARAM_NUM_SYMBOL_SET/MIMO_NUM_TX_ANT_SET));
        
        
        
        if(mimo_param_qam_val==64)
            
            mimo_param_k_QAM_val = 1/sqrt(42); 
            
            [tt mimo_PARAM_index_hldr] = sort(MIMO_MOD_QAM_64_PARAM_SET); 
            
            mod_set = MIMO_MOD_QAM_64_PARAM_SET; 
            
        elseif(mimo_param_qam_val==16)
            
            mimo_param_k_QAM_val = 1/sqrt(10);
            
            [tt mimo_PARAM_index_hldr] = sort(MIMO_MOD_QAM_16_PARAM_SET);
            
            mod_set = MIMO_MOD_QAM_16_PARAM_SET;
            
        elseif(mimo_param_qam_val==4)
            
            mimo_param_k_QAM_val = 1;
            
            [tt mimo_PARAM_index_hldr] = sort(MIMO_MOD_QPSK_PARAM_SET);
            
            mod_set = MIMO_MOD_QPSK_PARAM_SET;
            
        end
    else
        
        mimo_param_bit_per_symb = log2(mimo_param_qam_val); 
        
        mimo_param_k_QAM_val = 1;
        
        [tt mimo_PARAM_index_hldr] = sort(MIMO_MOD_BPSK_PARAM_SET);
        
        mod_set = MIMO_MOD_BPSK_PARAM_SET;
        
        QAMIQ = [-1; 1];
        
        MIMO_PARAM_ZF_MAT_VAL = MIMO_PARAM_TER_PROD(QAMIQ,ones(1,MIMO_PARAM_NUM_SYMBOL_SET/MIMO_NUM_TX_ANT_SET));
        
    end
    
 
    
    for mimo_par_lp_cntrl = 1:length(Eb_N0_dB)
        
        countiter = 0; 
        
        fprintf('\n At SNR = %d of %s \n',Eb_N0_dB(mimo_par_lp_cntrl),strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)));
        
        while(MIMO_PARAM_ZF_MMSE_MAX_SET>MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl) && countiter<MIMO_PARAM_MAX_SWP_SET)
            
            countiter = countiter+1;
            
            NNew=MIMO_PARAM_NUM_SYMBOL_SET*MIMO_NUM_TX_ANT_SET/mimo_chnl_sprt_BW; 
            s = zeros(1,NNew); 
            
            
            MIMO_Param_Tx_Data_Cont = MIMO_Chnl_DGen(MIMO_PARAM_NUM_SYMBOL_SET,1,[0,mimo_param_qam_val-1]); % MIMO_Param_Tx_Data_Cont sequence in decimal
            
            bitmod = QAMIQ(mimo_PARAM_index_hldr(MIMO_Param_Tx_Data_Cont+1)) ;
            
            s_precoded = bitmod *mimo_param_k_QAM_val; 
            

            d_btwc = mimo_num_Tx_set*MIMO_NUM_TX_ANT_SET; 
            
            s(1:d_btwc:NNew)=s_precoded(1:mimo_num_Tx_symbl_set:MIMO_PARAM_NUM_SYMBOL_SET); % s1
            
            s(2:d_btwc:NNew)=s_precoded(2:mimo_num_Tx_symbl_set:MIMO_PARAM_NUM_SYMBOL_SET); % s2
            
            s(3:d_btwc:NNew)= -(conj(s_precoded(2:mimo_num_Tx_symbl_set:MIMO_PARAM_NUM_SYMBOL_SET))); % -s2*
            
            s(4:d_btwc:NNew)= conj(s_precoded(1:mimo_num_Tx_symbl_set:MIMO_PARAM_NUM_SYMBOL_SET)); % s1*
            
            
            sMod = MIMO_PARAM_TER_PROD(s,ones(MIMO_NUM_RX_ANT_SET,1));
            
            sMod = reshape(sMod,[MIMO_NUM_RX_ANT_SET,MIMO_NUM_TX_ANT_SET,NNew/MIMO_NUM_TX_ANT_SET]);
            
            % chnl noise inclusion
            h_orig = 1/sqrt(2)*(randn(MIMO_NUM_RX_ANT_SET,MIMO_NUM_TX_ANT_SET,MIMO_PARAM_NUM_SYMBOL_SET/MIMO_NUM_TX_ANT_SET) + 1i*randn(MIMO_NUM_RX_ANT_SET,MIMO_NUM_TX_ANT_SET,MIMO_PARAM_NUM_SYMBOL_SET/MIMO_NUM_TX_ANT_SET));
            
            
            dummyarray=ones(mimo_num_Tx_set,1);
            hprime = reshape(h_orig,MIMO_NUM_RX_ANT_SET*MIMO_NUM_TX_ANT_SET,[]);
            h=reshape(MIMO_PARAM_TER_PROD(dummyarray,hprime),MIMO_NUM_RX_ANT_SET,MIMO_NUM_TX_ANT_SET,[]);
            
            
            n = 1/sqrt(2)*(randn(MIMO_NUM_RX_ANT_SET,NNew/MIMO_NUM_TX_ANT_SET) + 1i*randn(MIMO_NUM_RX_ANT_SET,NNew/MIMO_NUM_TX_ANT_SET));
            
            % Channel and noise Noise addition
            
            SNR = 10^(Eb_N0_dB(mimo_par_lp_cntrl)/10); 
            
            variance = MIMO_NUM_TX_ANT_SET/(2*SNR); 
            
            sigma = sqrt(variance); 
            
            y = reshape(sum(h.*sMod,2),MIMO_NUM_RX_ANT_SET,[]) + sigma*n; 
            
            % MIMO RECEIVER SIDE
       
            y= y./mimo_param_k_QAM_val;
            % zero-forcing (ZF) detection 
            
            h_orig = reshape(h_orig,MIMO_NUM_RX_ANT_SET,[]);
            
          
            
            firstterm = sum(y(:,1:mimo_num_Tx_set:end).*conj(h_orig(:,1:MIMO_NUM_TX_ANT_SET:end))...
                +conj(y(:,2:MIMO_NUM_TX_ANT_SET:end)).*h_orig(:,2:MIMO_NUM_TX_ANT_SET:end),1);
            secondtermTemp = sum(abs(h_orig).^2,1);
            
            secondterm = secondtermTemp(1:MIMO_NUM_TX_ANT_SET:end);
            
            for TxAnt = 2:MIMO_NUM_TX_ANT_SET
                
                secondterm = secondterm + secondtermTemp(TxAnt:MIMO_NUM_TX_ANT_SET:end);
                
            end
            
            secondterm = -1 + secondterm;
            
          
            
            firstterm_Matrix = MIMO_PARAM_TER_PROD(firstterm,ones(mimo_param_qam_val,1));
            
            secondterm_Matrix = MIMO_PARAM_TER_PROD(secondterm,ones(mimo_param_qam_val,1));
            
           
            
            s1_decision = abs((firstterm_Matrix - MIMO_PARAM_ZF_MAT_VAL)).^2 ...
                        + secondterm_Matrix.*abs(MIMO_PARAM_ZF_MAT_VAL).^2;
            
            [s1_min s1_index] = min(s1_decision);
            
            received_s1 = mod_set(s1_index);
            
            
            
            firstterm = sum(y(:,1:mimo_num_Tx_set:end).*conj(h_orig(:,2:mimo_num_Tx_set:end))...
                -conj(y(:,2:mimo_num_Tx_set:end)).*h_orig(:,1:mimo_num_Tx_set:end),1);
            
            
            
            firstterm_Matrix = MIMO_PARAM_TER_PROD(firstterm,ones(mimo_param_qam_val,1));
            
            
            
            s2_decision = abs((firstterm_Matrix - MIMO_PARAM_ZF_MAT_VAL)).^2 ...
                        + secondterm_Matrix.*abs(MIMO_PARAM_ZF_MAT_VAL).^2;
            
            [s2_min s2_index] = min(s2_decision);
            
            received_s2 = mod_set(s2_index);
            
            MIMO_Param_Rx_Data_Cont = zeros(MIMO_PARAM_NUM_SYMBOL_SET,1);
            
            MIMO_Param_Rx_Data_Cont(1:mimo_num_Tx_symbl_set:end)=received_s1;
            
            MIMO_Param_Rx_Data_Cont(2:mimo_num_Tx_symbl_set:end)=received_s2;
            
            MIMO_Param_Err_Cont = MIMO_Compute_BER_Param(MIMO_Param_Rx_Data_Cont,MIMO_Param_Tx_Data_Cont);

            if(MIMO_Param_Err_Cont)
                
                fprintf('E');
                
            else
                
                fprintf('S');
                
            end
            
            MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl) = MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl) + MIMO_Param_Err_Cont;
        
        end
        
        if(MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl)==0)
            
            maxEb = mimo_par_lp_cntrl;
            
            break;
        end
        
        MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl) = MIMO_PARAM_BERR_CONT(mimo_par_lp_cntrl)./(MIMO_PARAM_NUM_SYMBOL_SET*mimo_param_bit_per_symb*countiter);
    
    end
    
    if(mimo_mod_cntrl_param_varble==1)
        
        Ber = MIMO_PARAM_BERR_CONT;
        
        tempname = [filename '-' strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)) '.mat'];
        
        save(tempname, strtrim(filevar(1,:)), ...
            strtrim(filevar(2,:)), strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)));
    
    elseif(mimo_mod_cntrl_param_varble==2)
        
        Ber4 = MIMO_PARAM_BERR_CONT;
        
        tempname = [filename '-' strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)) '.mat'];
        
        save(tempname, strtrim(filevar(1,:)), ...
            strtrim(filevar(2,:)), strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)));
    
    elseif(mimo_mod_cntrl_param_varble==3)
        
        Ber16 = MIMO_PARAM_BERR_CONT;
        
        tempname = [filename '-' strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)) '.mat'];
        
        save(tempname, strtrim(filevar(1,:)), ...
            strtrim(filevar(2,:)), strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)));
    else
        
        Ber64 = MIMO_PARAM_BERR_CONT;
        
        tempname = [filename '-' strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)) '.mat'];
        
        save(tempname, strtrim(filevar(1,:)), ...
            strtrim(filevar(2,:)), strtrim(filevar(mimo_mod_cntrl_param_varble+2,:)));
    end
    
    MIMO_PARAM_BERR_CONT=zeros(1,length(Eb_N0_dB));

end

fprintf('\n');

MIMO_SIMULATION_COMPLETE_FLAG = 1;

