function B = B_at_point(ro0, fi0, z0, I, mu, r_sphere)
r0 = [ro0, fi0, z0]; %точка наблюдения
step_fi = pi/180; %шаг интегрирования по контуру
step_z = 0.1; %шаг по z
B = [0,0,0]; %ro, fi, z
for z = -r_sphere:step_z:r_sphere
    
    r = zeros(1,3);
    r(1,1) = sqrt(r_sphere^2-z^2);
    r(1,3) = z;
    
    dr = zeros(1,3);
    dr(1,2) = step_fi;
    
    k = (I*r(1,1)*mu/(4*pi*r_sphere))/((r0(1,1)-r(1,1))^2 + (r0(1,3)-r(1,3))^2)^1.5;
    for fi = step_fi:step_fi:2*pi
        r(1,2) = fi;
        B(1,1) = B(1,1) + k*(dr(1,2)*(r0(1,3)-r(1,3)) - dr(1,3)*(r0(1,2)-r(1,2)));
        %B(1,2) = B(1,2) - k*(dr(1,1)*(r0(1,3)-r(1,3)) - dr(1,3)*(r0(1,1)-r(1,1)));
        B(1,3) = B(1,3) + k*(dr(1,1)*(r0(1,2)-r(1,2)) - dr(1,2)*(r0(1,1)-r(1,1)));
    end
end