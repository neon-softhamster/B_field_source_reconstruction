function [Map_of_prob, Map_of_max] = Distr_of_prob_by_surf(B_points_xyz, B_vector_xyz, p_start, p_end, grid, sensivity, max_level)
i = 1;
Map_of_prob=zeros((ceil((p_end(1)-p_start(1))/grid)+1)*(ceil((p_end(2)-p_start(2))/grid)+1)*(ceil((p_end(3)-p_start(3))/grid)+1),4);
for x = p_start(1):grid:p_end(1)
    for y = p_start(2):grid:p_end(2)
        for z = p_start(3):grid:p_end(3)
            for surf = 1:1:length(B_points_xyz)
                Map_of_prob(i,1) = x;
                Map_of_prob(i,2) = y;
                Map_of_prob(i,3) = z;
                z_current = ((-B_vector_xyz(surf,1)*B_points_xyz(surf,1)-B_vector_xyz(surf,2)*B_points_xyz(surf,2)-B_vector_xyz(surf,3)*B_points_xyz(surf,3))+B_vector_xyz(surf,1)*x+B_vector_xyz(surf,2)*y)/-B_vector_xyz(surf,3);
                if ((z_current > z - grid) && (z_current < z + grid))
                    Map_of_prob(i,4) = Map_of_prob(i,4) + 1;
                end
            end
            i = i + 1;
        end
    end
end

nb_above_max = 0;
max_in_Map = max(Map_of_prob(:,4));
level = max_in_Map - max_level*max_in_Map;
length_Map = length(Map_of_prob);
for i = 1:1:length_Map
    if (Map_of_prob(i,4) < sensivity)
        Map_of_prob(i,4) = 0;
    end
    if (Map_of_prob(i,4) > level)
        nb_above_max = nb_above_max + 1;
    end
end

figure('Name','Histogram');
histogram(Map_of_prob(:,4),'BinLimits',[1,max_in_Map]);

figure('Name','Map of intersections');
scatter3(Map_of_prob(:,1),Map_of_prob(:,2),Map_of_prob(:,3),40,Map_of_prob(:,4),'.');
xlim([p_start(1) p_end(1)]);
ylim([p_start(2) p_end(2)]);
zlim([p_start(3) p_end(3)]);
xlabel('X');
ylabel('Y');
zlabel('Z');
cb = colorbar; % колорбар
cb.Label.String = 'Nb of intersections';

Map_of_max = zeros(nb_above_max, 4);
p = 1;
for i = 1:1:length_Map
    if (Map_of_prob(i,4) > level)
        Map_of_max(p,:) = Map_of_prob(i,:);
        p = p + 1;
    end
end

figure('Name','Ball position');
scatter3(Map_of_max(:,1),Map_of_max(:,2),Map_of_max(:,3),40,Map_of_max(:,4),'.');
xlim([p_start(1) p_end(1)]);
ylim([p_start(2) p_end(2)]);
zlim([p_start(3) p_end(3)]);
xlabel('X');
ylabel('Y');
zlabel('Z');
cb = colorbar; % колорбар
cb.Label.String = 'Nb of intersections';


