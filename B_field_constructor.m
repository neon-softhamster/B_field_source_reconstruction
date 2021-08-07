function [B_vector_xyz, B_points_xyz] = B_field_constructor(x, y, z, step_x0, step_y0, step_z0, r_sphere, pos_sphere, I, mu)

B_points_xyz = zeros(round(((x(2) - x(1))/step_x0 + 1)*((y(2) - y(1))/step_y0 + 1)*((z(2) - z(1))/step_z0 + 1)),3);
B_vector_xyz = B_points_xyz;
 
for sphere_n = 1:length(r_sphere)
    i = 1;
    for x0 = x(1):step_x0:x(2)
        for y0 = y(1):step_y0:y(2)
            for z0 = z(1):step_z0:z(2)
                B_vector_xyz(i,:) = B_vector_xyz(i,:) + B_at_point(x0, y0, z0, I, mu, r_sphere(sphere_n), pos_sphere(sphere_n,:));
                B_points_xyz(i,:) = [x0, y0, z0];
                i = i + 1;
            end
        end
    end
end