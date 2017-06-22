% Get homogeneous matrix for conic section M.
% M contains the arguments of the standard form.
function H = homogeneousMatrix(M)
  H = [
    M(1)   M(2)/2 M(4)/2;
    M(2)/2 M(3)   M(5)/2;
    M(4)/2 M(5)/2 M(6)
  ];
end
