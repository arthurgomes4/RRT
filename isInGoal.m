% this returns true if newNode is in the circular goal region with goalNode at its centre.
% goalNode = [ x y] 
% newNode = [x y ]
function [flag] = isInGoal( goalNode, newNode, goalRadius )
  
  if goalRadius > sqrt( sum( [goalNode-newNode].^2 ) )
    flag = true;
  else
    flag = false;
  endif
  
endfunction
