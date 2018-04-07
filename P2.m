%呂承翰 0516310
%按照公式運算，計算P時再分點計算
function P2_0516310
 N = 200;
 A = [10 8; -15 30]; d = [5 -10];
 X = randn(N,2) * A + repmat(d, N, 1);
 fn(X);
return;

function fn(X)
x = X(:,1);
y = X(:,2);
mx = sum(x)/length(x);
my = sum(y)/length(y);
M = [x-mx y-my];
E = cov(x, y);
m = [mx my];
for i = -100:100 
    for j = -100:100 
        n = [j i] - m; 
        pow = (-0.5) * n * inv(E) * n'; 
        P(i+101, j+101) = exp(pow) ./ sqrt((4*pi*pi) * det(E));
    end 
end
contourf(-100:100, -100:100, P);
colormap(summer);
hold on
plot(M(:, 1), M(:, 2), 'k.');
return;