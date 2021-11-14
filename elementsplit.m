function [snode, selem] = elementsplit(nodes, elems, iters)
if iters == 0
    snode = nodes;
    selem = elems;
end
if iters >= 1
    node_size = size(nodes);
    num_of_nodes = node_size(1);
    elem_size = size(elems);
    num_of_elem = elem_size(1);
    snode = zeros((num_of_elem +num_of_nodes),2);
    selem = zeros(2*num_of_elem,3);
    for j = 1:num_of_nodes
        snode(j,1) = nodes(j,1);
        snode(j,2) = nodes(j,2);
    end
    for i = 1:num_of_elem
        step = (2*i)-1;
        c = i + num_of_nodes;
        snode((c),1)= nodes(elems(i,1),1)+(nodes(elems(i,2),1) - nodes(elems(i,1),1))/2;
        snode((c),2)= nodes(elems(i,1),2)+(nodes(elems(i,2),2) - nodes(elems(i,1),2))/2;
        selem(step,1) = elems(i,1);
        selem(step,2) = i +num_of_nodes;
        selem(step,3) = elems(i,3);
        selem(step+1,1) = i+ num_of_nodes;
        selem(step+1,2) = elems(i,2);
        selem(step+1,3) = elems(i,3);
    end
    [snode,selem]= elementsplit(snode,selem,iters-1);
end
    
end
        