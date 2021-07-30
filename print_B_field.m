function endLoop = print_B_field(B_vector_xyz, B_points_xyz)

start_time = tic;
figure('Name','Field B');
quiver3(B_points_xyz(:,1),B_points_xyz(:,2),B_points_xyz(:,3),B_vector_xyz(:,1),B_vector_xyz(:,2),B_vector_xyz(:,3), 2, 'k');
xlabel('X')
ylabel('Y')
zlabel('Z')
axis equal;
endLoop = toc(start_time);