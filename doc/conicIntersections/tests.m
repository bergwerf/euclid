% Same test case as in test/conic_intersection_test.dart

a = [-349.9, 377.59, -785.68, 3032.65, 3093.44, -11736.67];
b = [-100.13, 272.09, -7.59, 196.76, -1453.65, 1938.82];
c = [-490.81, -99.46, -184.08, 5227.35, 1719.77, -14536.06];
A = [
  a(1)   a(2)/2 a(4)/2;
  a(2)/2 a(3)   a(5)/2;
  a(4)/2 a(5)/2 a(6)
];
B = [
  b(1)   b(2)/2 b(4)/2;
  b(2)/2 b(3)   b(5)/2;
  b(4)/2 b(5)/2 b(6)
];
C = [
  c(1)   c(2)/2 c(4)/2;
  c(2)/2 c(3)   c(5)/2;
  c(4)/2 c(5)/2 c(6)
];

ab = intersectConics(A, B);
ac = intersectConics(A, C);
bc = intersectConics(B, C);

