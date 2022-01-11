%generate sample node
function [ sampleNode ] = randomNodeGenerator(xLimits,yLimits)
  
sampleNode = [ xLimits(1) + ( xLimits(2) - xLimits(1) )*rand()  yLimits(1) + ( yLimits(2) - yLimits(1) )*rand() ];
  
endfunction