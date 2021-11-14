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


  The node file should contain x and y coordinates separated like this
  The element file should contain the node number at each end of the element. In MATLAB, index starts from one, so refer to the node file as you are connecting. The third column  in the element file is for identification of material types. This can also be configured in `get_material_prop.m`
  
  
3. Create Boundary Condition file
4. Configure Loading Conditions
5. Run
