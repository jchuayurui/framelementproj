function val = get_material_prop(prop_type, elem_type)
% returns material properties based on property type and element type

material_prop = zeros(4,2);

% properties for element type 1
material_prop(1,1) = 78.5e9;                  % Young's Modulus
material_prop(2,1) = 1.5;                    % element width
material_prop(3,1) = 0.5;                    % element height
material_prop(4,1) = 19300;                   % density

% properties for element type 2
material_prop(1,2) = 78.5e9;             % Young's Modulus
material_prop(2,2) = 0.6;                 % element width
material_prop(3,2) = 0.3;               % element height
material_prop(4,2) = 19300;          % density

switch prop_type
    case 'E'
        prop_type = 1;
    case 'b'
        prop_type = 2;
    case 'h'
        prop_type = 3;
    case 'p'
        prop_type = 4;
end

val = material_prop(prop_type, elem_type);