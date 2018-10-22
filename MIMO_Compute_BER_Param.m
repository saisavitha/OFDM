function MIMO_Param_Err_Cont = MIMO_Compute_BER_Param(MIMO_Param_Tx_Data_Cont,MIMO_Param_Rx_Data_Cont)

diff = bitxor(MIMO_Param_Tx_Data_Cont,MIMO_Param_Rx_Data_Cont);

MIMO_Param_Err_Cont = 0;

while(sum(diff))
    
    lastbit = bitand(diff,1);
    
    MIMO_Param_Err_Cont = MIMO_Param_Err_Cont + sum(lastbit);
    
    diff=bitshift(diff,-1);
    
end

