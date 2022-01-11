% adds the Heuristic cost to go column in the nodes matrix 
function [ nodes ] = calculateHCTG( nodes,goalNode )
  nodes = [ nodes(:,1:3) sqrt(sum([ goalNode - nodes(:,2:3) ].^2,2))];
endfunction
