% 0516310 Cheng-Han Lu
% These are "sufficient" comments!!!!
classdef Point2
    properties
        x
        y
    end
    methods
        function obj = Point2(s, t)
            if(~nargin)
                obj.x = 0;
                obj.y = 0;
                return;
            elseif(nargin == 1)
                [x y] = size(s);
                if(y == 1)
                    obj.x = s(1, 1);
                    obj.y = s(2, 1);
                else
                    obj = [];
                    for i = 1:y
                        obj = [obj Point2([s(1, i); s(2, i)])];
                    end
                end
            else
                l = length(s);
                obj = [];
                for i = 1:l
                    obj = [obj Point2([s(i);t(i)])];
                end
            end
        end
        function obj = norm(s)
            l = length(s);
            obj = [];
            for i = 1:l
                obj = [obj norm([s(i).x s(i).y])];
            end
        end
        function disp(s)
            [x y] = size(s);
            for i = 1:x
                for j = 1:y
                    fprintf('(%d,%d) ', s(i, j).x, s(i, j).y);
                end
                fprintf('\n');
            end
        end
        function obj = plus(m, n)
            [x1 y1] = size(m);
            [x2 y2] = size(n);
            obj = Point2();
            if(isnumeric(m)) obj = n + Point2(m, m);
            elseif(isnumeric(n)) obj = m + Point2(n, n);
            elseif(x1*y1 == 1 && x2*y2 == 1) 
                obj.x = m.x+n.x;
                obj.y = m.y+n.y;
            elseif(x1*y1 == 1) obj = n + m;
            elseif(x2*y2 == 1)
                obj = [];
                for i = 1:x1
                    rt = [];
                    for j = 1:y1
                        rt = [rt m(i, j)+n];
                    end
                    obj = [obj;rt];
                end
            elseif(x1 == x2 && y1 == y2)
                obj = [];
                for i = 1:x1
                    rt = [];
                    for j = 1:y1
                        rt = [rt m(i, j)+n(i, j)];
                    end
                    obj = [obj ; rt];
                end
            else error('Wrong size');
            end
        end
        function obj = minus(m, n)
            if(isnumeric(n)) obj = m + Point2(-n, -n);
            else
                [x y] = size(n);
                for i = 1:x
                    for j = 1:y
                        n(i, j).x = -n(i, j).x;
                        n(i, j).y = -n(i, j).y;
                    end
                end
                obj = m + n;
            end
        end
        function obj = eq(m, n)
            [x1 y1] = size(m);
            [x2 y2] = size(n);
            if(isnumeric(m)) obj = n == Point2(m, m);
            elseif(isnumeric(n)) obj = m == Point2(n, n);
            elseif(x1*y1 == 1 && x2*y2 == 1) obj = (m.x == n.x) & (m.y == n.y);
            elseif(x1*y1 == 1) obj = n == m;
            elseif(x2*y2 == 1) 
                obj = [];
                for i = 1:x1
                    rt = [];
                    for j = 1:y1
                        rt = [rt (m(i, j) == n)];
                    end
                    obj = [obj; rt];
                end
            elseif(x1 == x2 && y1 == y2)
                 obj = [];
                for i = 1:x1
                    rt = [];
                    for j = 1:y1
                        rt = [rt (m(i, j) == n(i, j))];
                    end
                    obj = [obj; rt];
                end
            else error('Wrong size');
            end
        end
        function obj = sum(s)
            l = length(s);
            obj = Point2();
            obj.x = 0;
            obj.y = 0;
            for i = 1:l
                obj.x = obj.x + s(i).x;
                obj.y = obj.y + s(i).y;
            end
        end
        function obj = mean(s)
            l = length(s);
            obj = sum(s);
            obj.x = obj.x / l;
            obj.y = obj.y/l;
        end
    end
end