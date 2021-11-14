# Frame Element in 2D Truss

*Credits to: Prof Lim, Prof Ong, A.J.M. Ferreira, Euler, Newton, Hooke, Bernoulli, Cauchy, and everyone who has furthered engineering through the pursuit of Analytical, Numerical, and Computational Methods*

Created by:
Ricky Theodore
Clement Arthur Fischer
Ng Cen Sen Terence
Chua Yu Rui

As part of ME4291 Finite Element Analysis Project

# Usage
1. Create Node and Element connectivity file

  Let us take a sample structure with 2 material types
  
  ![Sample Structure](/images/nodeno.png)
  The node file should contain x and y coordinates separated like this
  
  ![Sample Node file](/images/nodalcoordinates.JPG)
  The element file should contain the node number at each end of the element.
  
  ![Sample Element file](/images/elemcon.JPG)
  
  
  In MATLAB, index starts from one, so refer to the node file as you are connecting. The third column in the element file is for identification of material types. This can also be configured in `get_material_prop.m`
  
  
  It is important to note that this will only result in 2 nodes per truss element. In `Truss2D.m`, there is a script calling `elementsplit.m` which allows you to split into as many elements as you want. Well, not exactly. The function splits recursively such that number of elements split is 2^n with n being the number of iterations. The corresponding number of nodes is 2^n +1. This script retains the original input nodes, and adds in nodes for the split elements at the end of the file, such that loading and boundary conditions do not need to be change should convergent studies be attempted. 
  
  If we load these sample files as `nodes = load('nodalcoordinates.txt'); elems = load('elemconnect.txt');` and script the example file as `[nodes, elems] = elementsplit(nodes,elems,1)`, we will obtain the following:
  
  New Node data
  ![New Nodes](/images/newnodes.JPG)
  
  New Element data
  ![New Elements](/images/newelems.JPG)
  
  Visual representation
  ![Visual](/images/newvisual.JPG)
  
  This is pretty neat for identifying node numbers where you will either set boundary conditions or increase load. For example, you now know that the complete center is at node 9, and no matter how many iterations you do, it will still be node 9. The split elements also retain the material type in the third column.
  
3. Create Boundary Condition file

  Understanding the Boundary Condition file is important as well. Let us take a look at an example of a Cantilever.
  
  ![Cantilever](/images/cantileverbc.JPG)
  
  The first column indicates the node number, and the second column indicates which degree of freedom. In a Frame element, 1 indicates degree of freedom in the x-axis, 2 indicates degree of freedom in y-axis, and 3 indicates degree of freedom in rotation. In a cantilever boundary condition, all 3 are fixed to zero, and the main script recognizes this and eliminates it from the global matrix so that it can solve the global matrix using its algorithms.
  
  This is an example of a pinned support at node 1 and a roller support at node 4
  
  ![PinRoller](/images/pin1roller4.JPG)
  
  As we know, pinned supports are free to rotate and roller supports are free to slide. Thus the only degree of freedom we set in this example file is 1 and 2 for node 1, and 2 for node 4.
  
  Lastly, let us take a look at a pinned support on both ends.
  
  ![Pinned](/images/pin14.JPG)
  
  This is what we can expect to see in a truss and we have used it for our project as well.
5. Configure Loading Conditions
6. Run
