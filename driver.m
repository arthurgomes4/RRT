%the main code that runs the show

%==================== load parameters here =====================================

obs = csvread('obstacles.csv')   ;              % obs = [ x y radius ]
%obs(:,3) = obs(:,3)/2;
tempNodes = csvread('SGnodes.csv');
startNode = tempNodes(1,1:2);                                 % startNode = [ x y ]
goalNode = tempNodes(end,1:2);                                     % goalNode = [ x y ]
goalRadius = tempNodes(end,3);                                
xLimits = [ 0, 800];                         
yLimits = [ 0, 800]; 
nodes = [ 1 startNode 0 0 ]; 
MAX = 4000;                                                 %max number of nodes
edges = [];
stepSize = 20;
success = false;

%===============================================================================

while size(nodes,1) < MAX
  
  sampleNode = randomNodeGenerator(xLimits,yLimits);
  
  nn  = findNearestNode( nodes, sampleNode );
  
  [nodes edges success] = stepTowards(nodes, edges, obs, sampleNode, nodes(nn,:), stepSize);
 
  if success 
    if isInGoal( goalNode, nodes(end,2:3), goalRadius )
       Path = passPath(nodes);
       success = true;
       break
    endif
  endif
 
endwhile

% nodes must be modded further to have the form [ ID x y HCTG ]
% edges also should have form [ ID1 ID2 cost ]
% path requires no change

if success
  nodes = calculateHCTG(nodes,goalNode);
  csvwrite('nodes.csv',nodes);
  csvwrite('edges.csv',edges);
  csvwrite('path.csv',Path);
  fprintf('SUCCESS\n')
  disp(Path);
else 
  fprintf('FAILURE\n')
end
