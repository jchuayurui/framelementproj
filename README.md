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
  
  ![New Nodes](/images/newnodes.JPG)
  ![New Elements](/images/newelems.JPG)
  ![Visual](/images/newvisual.JPG)
  
  
3. Create Boundary Condition file
4. Configure Loading Conditions
5. Run
