% node1 [ x1 y1 ] is the start point
% node2 [ x2 y2 ] is the end point 
% obs is of the form [ x y radius ] per row


function [ result ] = detectObs( obs, node1, node2)
  limits = [ 800, 800; 0, 0];   % 0.5 0.5 ; -0.5 -0.5 for assignment 
  
%================== check if within boundary =================================== 
  if any(node2 > limits(1,:)) || any(node2 < limits(2,:))
    result = false;
    return
  endif

%====================== check if goto point is in circle =======================
if any( sqrt( sum((node2 - obs(:,1:2)).^2,2) ) <= obs(:,3) )
  result = false;
  return
endif 
%========== get list of circles intersected by the line equation ================
  a = node1(2) - node2(2);
  b = -(node1(1) - node2(1));
  c = node2(2)*node1(1) - node1(2)*node2(1);
  A = a^2 + b^2;
  Cdist = abs( sum( obs(:,1:2).*[ a b ], 2) + c )/sqrt(A);
  circles = obs( find(Cdist <= obs(:,3)) , : );

%=============== some vector shit===============================================
  maga = sqrt([node2 - node1]*[node2 - node1]');
  proj = ([node2 - node1]*[circles(:,1:2) - node1]')'/ maga;
  
  if any(find((proj>0) .* (proj<maga)))
    result = false;
    return 
  endif 

##%======================= calculate quadratic coeffs ============================
##  a = -a;
##  B =  2*sum((node1 - circles(:,1:2)).*[b a],2);
##  C = sum( [[node1 0] - circles].^2, 2);
##  F = [sum( [ node2 - node1 ].^2 , 2 ).*ones(length(B),1) B C];
##
##%======================= find roots ============================================
##  for i = 1:size(circles,1)
##    ret = real(roots(F(i,:))(:)')
##
##    if any(ret > [0 0]) && any(ret < [1 1])
##      result = false;
##      fprintf('blocked\n')
##      return
##    endif
##  endfor
 result = true;
 
endfunction
