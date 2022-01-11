% finds extra connections between nodes  

function [ edges ] = findExtraEdges(nodes,edges,obs)
  
  marker = zeros(size(nodes,1));
  marker(edges(:,1),edges(:,2)) = 1;
  marker(edges(:,2),edges(:,1)) = 1;
  
  for i = 1:size(nodes,1)
    for j = 1:size(nodes,1)
      if marker(i,j) == 0
        if detectObs( obs, nodes(i,2:3), nodes(j,2:3) )
           edges = [ edges; i j sqrt(sum([nodes(i,2:3) - nodes(j,2:3) ].^2)) ];
           marker(j,i) = 1;
        endif
      endif
    endfor
  endfor
endfunction
