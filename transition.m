function [B_points_xyz] = transition(Dx, Dy, Dz, B_points_xyz)
for i = 1:1:length(B_points_xyz)
    B_points_xyz(i,:) = B_points_xyz(i,:) + [Dx, Dy, Dz];
end