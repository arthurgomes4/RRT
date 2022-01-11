% find the nearest node to the new node 
% nodes = [ ID x y cost parent ]
% newNode = [ x y ]

function [ pos ] = findNearestNode( nodes, sampleNode )
  
  [ dist pos ] = min(sqrt(sum([ sampleNode - nodes(:,2:3) ].^2,2)));
  
endfunction
