function [B_points_xyz, B_vector_xyz] = clear_B(B_points_xyz, B_vector_xyz) % зануление поля под землей
nb_null = 0;
length_B_field = length(B_points_xyz);
for p = 1:1:length_B_field
    if (B_points_xyz(p,3) < 0)
        nb_null = nb_null + 1;
    end
end

fit = 0;
for p = 1:1:length_B_field
    if (B_points_xyz(p - fit,3) < 0)
        B_points_xyz(p - fit,:) = [];
        B_vector_xyz(p - fit,:) = [];
        fit = fit + 1;
    end
end