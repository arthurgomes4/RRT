% nodes = [ ID x y parent cost ]
% CAUTION: this works on the assumption that the nodes are arranged so that the
%          node ID matches the row index and the goalNode is the last one and the 
%          start node is the first one

function [ Path ] = passPath(nodes)
  Path = [ nodes(end,1) ];
  while Path(1) > 1
    Path = [ nodes(Path(1),4) Path ];
  endwhile
endfunction
