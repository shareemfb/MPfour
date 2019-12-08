h = input('Input the initial height of the projectile above the ground (meters): ');
Vi = input('Input the magnitude of the velocity (m/s): ');    
angle = input('Input the angle with respect to the x-axis at which the projectile is fired (degrees): ');
Ax = input('Input the x-component of the acceleration (meters/s^2): ');

x = true;
while(x==true)
    Ay = input('Input the y-component of the acceleration (meters/s^2): ');
    if (Ay~=0)
        x = false;
    else
        x = true;
        disp('Vertical acceleration cannot be zero!');
    end
end

if Ay > 0
    Ay = -(Ay);
end

Vix = Vi*cosd(angle);
Viy = Vi*sind(angle);

%ideal motion:

%total time of the trajectory
%equation: y = Viy*t + (1/2)*(-9.8)*(t^2);
time = [((1/2)*(-9.8)), Viy, h];
t_all = roots(time);
t_real = t_all(~imag(t_all));
t_positive = t_real(t_real>0);
t = linspace(0,(t_positive),50);

x = Vix.*t;
y = [];

for i = 1:50
    if t(i) == 0
        fy = h;
    elseif t(i) > 0
        fy = Viy*t(i) + (1/2)*(-9.8)*(t(i)^2) + h;
    end
    y(i) = fy;
end

figure, plot(x,y, '-r', 'linewidth', 2)
hold on
grid on

% non-ideal motion:

%total time of trajectory:
%equation: y = Viy*t + (1/2)*Ay*t^2
A = (1/2)*Ay;
time = [A, Viy, h];
t_all = roots(time);
t_real = t_all(~imag(t_all));
t_positive = t_real(t_real>0);
t_final = linspace(0,(t_positive),50);
y2 = [];
x2 = Vix.*t + (1/2)*Ax*(t.^2);

for i = 1:50
    if t_final(i) == 0
        fy = h;
    elseif t_final(i) > 0
        fy = Viy*t_final(i) + (1/2)*Ay*(t_final(i)^2) + h;
    end
    y2(i) = fy;
end

plot(x2, y2, '-.b', 'linewidth', 2)
xlabel 'horizontal distance'
ylabel 'vertical distance'
title 'Trajectory of a Projectile'
legend('ideal', 'non-ideal')



