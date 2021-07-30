clear;
ro0n =      6;          %размеры поля перпендикулярно оси шара
step_ro0 =  0.5;        %шаг сетки по ро
z0n =       12;          %размеры поля вдоль оси шара
step_z0 =   0.5;        %шаг сетки по z
fi0n =      2*pi;       %угол от 0 до fi0n
step_fi0 =  2*pi/48;    %количество точек сетки по углу
I =         100000;     %воображаемый ток
mu =        1;          %проницаемость вакуума
r_sphere =  1;          %радиус шара

B_vector = zeros(round(ro0n*(2*pi/step_fi0)*z0n),3);
B_vector_xyz = B_vector;
B_points_xyz = B_vector;
i = 1;
for fi0 = step_fi0:step_fi0:fi0n
    for ro0 = step_ro0:step_ro0:ro0n
        for z0 = -z0n/2:step_z0:z0n/2
            B_vector(i,:) = B_at_point(ro0, fi0, z0, I, mu, r_sphere);
            B_vector_xyz(i,1) = B_vector(i,1)*cos(fi0);
            B_vector_xyz(i,2) = B_vector(i,1)*sin(fi0);
            B_vector_xyz(i,3) = B_vector(i,3);
            B_points_xyz(i,1) = ro0*cos(fi0);
            B_points_xyz(i,2) = ro0*sin(fi0);
            B_points_xyz(i,3) = z0;
            i = i + 1;
        end
    end
end

[B_points_xyz, B_vector_xyz] = rotation(pi/10, pi/3, pi/2, B_points_xyz, B_vector_xyz); 
%поворот на углы вокруг осей x, y и z последовательно

[B_points_xyz] = transition(3, 4, -5, B_points_xyz); 
%трансляция центра шара в точку x, y и z

[B_points_xyz, B_vector_xyz] = clear_B(B_points_xyz, B_vector_xyz); 
%убирает поле z < 0

time_to_print_B = print_B_field(B_vector_xyz, B_points_xyz); 
%рисует поле

[Map_of_prob, Map_of_max] = Distr_of_prob_by_surf(B_points_xyz, B_vector_xyz, [-10,-10,-10], [10,10,10], 0.5, 0, 0.7); 
%точки, векторы, начало сектки, конец сетки, шаг сетки, отсечение шума,
%процент от максимума, который выводится