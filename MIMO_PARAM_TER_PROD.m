function MIMO_PARAM_PROD_OUT = MIMO_PARAM_TER_PROD(MIMO_PARAM_IN1,MIMO_PARAM_IN2)

if ~ismatrix(MIMO_PARAM_IN1) || ~ismatrix(MIMO_PARAM_IN2)
    error(message('MATLAB:MIMO_PARAM_TER_PROD:TwoDInput'));
end

[ma,na] = size(MIMO_PARAM_IN1);
[mb,nb] = size(MIMO_PARAM_IN2);

if ~issparse(MIMO_PARAM_IN1) && ~issparse(MIMO_PARAM_IN2)

   

   [ia,ib] = meshgrid(1:ma,1:mb);
   [ja,jb] = meshgrid(1:na,1:nb);
   MIMO_PARAM_PROD_OUT = MIMO_PARAM_IN1(ia,ja).*MIMO_PARAM_IN2(ib,jb);

else

  

   [ia,ja,sa] = find(MIMO_PARAM_IN1);
   [ib,jb,sb] = find(MIMO_PARAM_IN2);
   ia = ia(:); ja = ja(:); sa = sa(:);
   ib = ib(:); jb = jb(:); sb = sb(:);
   ka = ones(size(sa));
   kb = ones(size(sb));
   t = mb*(ia-1)';
   ik = t(kb,:)+ib(:,ka);
   t = nb*(ja-1)';
   jk = t(kb,:)+jb(:,ka);
   MIMO_PARAM_PROD_OUT = sparse(ik,jk,sb*sa.',ma*mb,na*nb);

end
