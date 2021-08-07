function B_temp = B_at_point(x0, y0, z0, I, mu, r_sphere, tr)
% перенос сферы в точку с координатами [tr(1), tr(2), tr(3)] (на самом деле тут сдвигается сама точка наблюдения)
x0 = x0 - tr(1);
y0 = y0 - tr(2);
z0 = z0 - tr(3);

% перевод декартовых координат в цилиндрические
ro0 = sqrt(x0^2 + y0^2);
if y0 > 0
    fi0 = acos(x0/sqrt(x0^2 + y0^2));
else
    fi0 = -acos(x0/sqrt(x0^2 + y0^2));
end

r0 = [ro0, fi0, z0];        % точка наблюдения 
step_fi = pi/180;           % шаг интегрирования по контуру
step_z = 0.1;               % шаг по z
B = [0,0,0];                % B в точке (ro, fi, z)

% Берется контур с током в плоскости XoY
for z = -r_sphere:step_z:r_sphere
    
    r = zeros(1,3);
    r(1) = sqrt(r_sphere^2-z^2);
    r(3) = z;
    
    dr = zeros(1,3);
    dr(2) = step_fi;
    
    k = (I*r(1)*mu/(4*pi*r_sphere))/((r0(1)-r(1))^2 + (r0(3)-r(3))^2)^1.5;
    for fi = step_fi:step_fi:2*pi
        r(2) = fi;
        B(1) = B(1) + k*(dr(2)*(r0(3)-r(3)) - dr(3)*(r0(2)-r(2)));
        B(2) = B(2) - k*(dr(1)*(r0(3)-r(3)) - dr(3)*(r0(1,1)-r(1)));
        B(3) = B(3) + k*(dr(1)*(r0(2)-r(2)) - dr(2)*(r0(1,1)-r(1)));
    end
end

B_temp = [0,0,0];
B_temp(1) = B(1)*cos(fi0);
B_temp(2) = B(1)*sin(fi0);
B_temp(3) = B(3);

if (sqrt(x0^2 + y0^2 + z0^2) < (r_sphere + 0.5) || (x0^2 + y0^2) == 0)
    B_temp = [0,0,0];
end