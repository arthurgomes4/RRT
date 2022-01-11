% function to step towards the randomly generated node from the nearest node 
% returns false if path is blocked and true if path is found
% if path exists create node and make its parent = nearestNode and its cost = distance to the nearestNode + the cost of the nearest node 
% sampleNode = [ x y ] 
% nearestNode = [ ID x y parent cost ]
% nodes = [ ID x y parent cost]
% edges = [ node1 node2 cost ]
% obs = [ x y radius ]

function [ nodes edges success ] = stepTowards( nodes, edges, obs, sampleNode, nearestNode, stepSize)
                                        
  tempVec = sampleNode - nearestNode(2:3);
  tempVecMag = sqrt(sum(tempVec.^2));
  
  if tempVecMag < stepSize
    tempNewNode = sampleNode;
    tempCost = tempVecMag;
  else
    tempUnitVec = tempVec / tempVecMag;
    tempNewNode = stepSize*tempUnitVec + nearestNode(2:3);
    tempCost = stepSize;
  endif

  if detectObs(obs,nearestNode(2:3),tempNewNode) 
    nodes = [ nodes ; nodes(end,1)+1 tempNewNode nearestNode(1) tempCost+nearestNode(5) ];
    edges = [ edges ; nearestNode(1) nodes(end,1) tempCost ];
    success = true;
    return
  endif
  
  success = false;
    
endfunction
