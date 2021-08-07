clear;
step_x0 =       0.5;                            %шаг сетки по x
step_y0 =       0.5;                            %шаг сетки по y
step_z0 =       0.5;                            %шаг сетки по z
x =             [-10, 10];                      %размеры поля по оси x
y =             [-10, 10];                      %размеры поля по оси y
z =             [0, 6];                         %размеры поля по оси z
I =             10;                             %воображаемый ток
mu =            1;                              %проницаемость вакуума
r_sphere =      [1, 2];                         %радиус шаров
pos_sphere =    [  -2,     -1,      -2;         % координаты центра шаров построчно
                    1,      3,      -3];

% Генерирует векторное поле
[B_vector_xyz, B_points_xyz] = B_field_constructor(x, y, z, step_x0, step_y0, step_z0, r_sphere, pos_sphere, I, mu);

time_to_print_B = print_B_field(B_vector_xyz, B_points_xyz); 
%рисует поле

[Map_of_prob, Map_of_max] = Distr_of_prob_by_surf(B_points_xyz, B_vector_xyz, [-10,-10,-10], [10,10,10], 0.5, 0, 0.7); 
%точки, векторы, начало сектки, конец сетки, шаг сетки, отсечение шума,
%процент от максимума, который выводится