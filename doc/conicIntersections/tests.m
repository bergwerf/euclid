% Same test case as in test/conics_test.dart

a = [-349.9, 377.59, -785.68, 3032.65, 3093.44, -11736.67];
b = [-100.13, 272.09, -7.59, 196.76, -1453.65, 1938.82];
c = [-490.81, -99.46, -184.08, 5227.35, 1719.77, -14536.06];

line = [0, 0, 0, 1, -1, 0];
circle = [1, 0, 1, 0, 0, -1];
line2 = [0, 0, 0, -1, -1, 4];
ellipse = [0.7810550637051784, -0.6819730701192613, 0.4689449362948217,
          -0.8801370572910955, -0.25591680247038207, -0.4319730701192612];

A = homogeneousMatrix(a);
B = homogeneousMatrix(b);
C = homogeneousMatrix(c);

Line = homogeneousMatrix(line);
Circle = homogeneousMatrix(circle);
Line2 = homogeneousMatrix(line2);
Ellipse = homogeneousMatrix(ellipse);

%ab = intersectConics(A, B);
%ac = intersectConics(A, C);
%bc = intersectConics(B, C);

%lc = intersectConics(Circle, Line);
le = intersectConics(Line2, Ellipse);
