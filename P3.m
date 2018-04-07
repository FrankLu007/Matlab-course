% 0516310 呂承翰
% 透過front, back, q來實作出queue
function [C imL] = P3_0516310(im)
[lx ly] = size(im);
nC = 0;
imL = zeros(lx, ly);
q = [];
front = 0;
back = 0;
for i = 1:lx
    for j = 1:ly
        if(im(i, j) && imL(i, j) == 0)
            nC = nC + 1;
            front = 1;
            back = 2;
            q(1) = i * ly + j;
            im(i, j) = 0;
            C(nC).count = 0;
            C(nC).index = [];
            C(nC).xmax = i;
            C(nC).xmin = i;
            C(nC).ymax = j;
            C(nC).ymin = j;
            while front ~= back
                x = floor(q(front)/ly);
                y = mod(q(front), ly);
                if(y == 0)
                    y = ly;
                    x = x - 1;
                end
                front = front + 1;
                imL(x, y) = nC;
                C(nC).index = [C(nC).index y*lx+x];
                C(nC).count = C(nC).count + 1;
                if(x > C(nC).xmax) C(nC).xmax = x; end
                if(x < C(nC).xmin) C(nC).xmin = x; end
                if(y > C(nC).ymax) C(nC).ymax = y; end
                if(y < C(nC).ymin) C(nC).ymin = y; end
                if(x+1 <= lx && im(x+1, y) && imL(x+1, y) == 0)
                    q(back) = (x+1) * ly + y;
                    im(x+1, y) = 0;
                    back = back + 1;
                end
                if(x > 1 && im(x-1, y) && imL(x-1, y) == 0)
                    q(back) = (x-1) * ly + y;
                    im(x-1, y) = 0;
                    back = back + 1;
                end
                if(y+1 <= ly && im(x, y+1) && imL(x, y+1) == 0)
                    q(back) = x * ly + y + 1;
                    im(x, y+1) = 0;
                    back = back + 1;
                end
                if(y > 1 && im(x, y-1) && imL(x, y-1) == 0)
                    q(back) = x * ly + y - 1;
                    im(x, y-1) = 0;
                    back = back + 1;
                end
            end
        end
    end
end
imagesc(imL);
end