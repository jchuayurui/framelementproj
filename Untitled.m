b = get_material_prop(2,1)
h = get_material_prop(3,1)

I = (1/12)*b*h^3
x = linspace(0,1)
f = ((rho*b*h*9.81)/(E*I))*(-((x.^2)/4) + ((x.^3)/6) - ((x.^4)/24))