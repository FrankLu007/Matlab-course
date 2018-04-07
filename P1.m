% ¥i§ïa, b, y
a = 3;
b = 100;
x = a:b;
len = length(x);
y = sin(.05*x + .002*x.^2) .* (1 - x.*x/20000);
ly = [y(3:len)];
ry = [y(1:len-2)];
f = zeros(1, len);
f(2:len-1) = y(2:len-1) >= ly;
f(2:len-1) = f(2:len-1) + (y(2:len-1) >= ry);
maximum = find(f == 2);
lmax = length(find(f == 2));
f = zeros(1, len);
f(2:len-1) = y(2:len-1) <= ly;
f(2:len-1) = f(2:len-1) + (y(2:len-1) <= ry);
minimum = find(f == 2);
lmin = length(find(f == 2));
maximum = repmat(maximum, 2, 1);
minimum = repmat(minimum, 2, 1);
minimum(2, 1:lmin) = y(minimum(1, 1:lmin));
maximum(2, 1:lmax) = y(maximum(1, 1:lmax));
minimum(1, 1:lmin) = minimum(1, 1:lmin) + 2;
maximum(1, 1:lmax) = maximum(1, 1:lmax) + 2;
fprintf('Local maximums:\n')
fprintf(' ( %d, %.2f)\n', maximum)
fprintf('Local minimums:\n')
fprintf(' ( %d, %.2f)\n', minimum)
plot(x, y, 'b.', 'MarkerSize', 10)
hold on
plot(maximum(1, 1:lmax), maximum(2, 1:lmax), 'rs', 'MarkerSize', 20)
hold on
plot(minimum(1, 1:lmin), minimum(2, 1:lmin), 'rs', 'MarkerSize', 20)
hold on 
plot(x, y, 'b')
all = zeros(1, lmax+lmin+2);
all(1:lmax) = maximum(1, 1:lmax);
all(lmax+1:lmax+lmin) = minimum(1, 1:lmin);
all(lmax+lmin+1) = x(1);
all(lmax+lmin+2) = x(len);
all = sort(all);
fprintf('Monotonically increasing segments:\n')
if maximum(1) < minimum(1)
    if maximum(1, lmax) < minimum(1, lmin)
        fprintf('%d - %d\n', all(1:length(all)))
    else
        fprintf('%d - %d\n', all(1:length(all)-1))
    end
else
    if maximum(1, lmax) < minimum(1, lmin)
        fprintf('%d - %d\n', all(2:length(all)))
    else
        fprintf('%d - %d\n', all(2:length(all)-1))
    end
end
fprintf('Monotonically decreasing segments:\n')
if maximum(1) < minimum(1)
    if maximum(1, lmax) < minimum(1, lmin)
        fprintf('%d - %d\n', all(2:length(all)-1))
    else
        fprintf('%d - %d\n', all(2:length(all)))
    end
else
    if maximum(1, lmax) < minimum(1, lmin)
        fprintf('%d - %d\n', all(1:length(all)-1))
    else
        fprintf('%d - %d\n', all(1:length(all)))
    end
end
    