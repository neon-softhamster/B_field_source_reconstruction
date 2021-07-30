function [B_points_xyz, B_vector_xyz] = rotation(alpha_x, alpha_y, alpha_z, B_points_xyz, B_vector_xyz)

% step_rotation = pi/180; %шаг вращения
% 
% Lx = [0 0 0;0 0 -1;0 1 0];
% Ly = [0 0 1;0 0 0;-1 0 0];
% Lz = [0 -1 0;1 0 0;0 0 0];
% 
% Rx = expm(step_rotation*Lx);
% Ry = expm(step_rotation*Ly);
% Rz = expm(step_rotation*Lz);
    
Rx = [  1               0               0               ;
        0               cos(alpha_x)    -sin(alpha_x)   ;
        0               sin(alpha_x)    cos(alpha_x)    ];
    
Ry = [  cos(alpha_y)    0               sin(alpha_y)    ;
        0               1               0               ;
        -sin(alpha_y)   0               cos(alpha_y)    ];
    
Rz = [  cos(alpha_z)    -sin(alpha_z)   0               ;
        sin(alpha_z)    cos(alpha_z)    0               ;
        0               0               1               ];
    
R = Rx*Ry*Rz;

length_B_field = length(B_vector_xyz);
for p = 1:1:length_B_field
	B_points_xyz(p,:) = R*(B_points_xyz(p,:)');
%     B_points_xyz(p,:) = Ry*B_points_xyz(p,:)';
%     B_points_xyz(p,:) = Rz*B_points_xyz(p,:)';

    B_vector_xyz(p,:) = R*(B_vector_xyz(p,:)');
%     B_vector_xyz(p,:) = Ry*B_vector_xyz(p,:)';
%     B_vector_xyz(p,:) = Rz*B_vector_xyz(p,:)';
end