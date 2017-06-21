// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

// MatLab like functions.

List<num> abs(List<num> input) => input.map((n) => n.abs()).toList();

num maxN(List<num> input) => input.reduce(max);

Vector3 diag3(Matrix3 mat) =>
    vec3(mat.entry(0, 0), mat.entry(1, 1), mat.entry(2, 2));

Matrix3 inv3(Matrix3 mat) {
  return new Matrix3.zero()..copyInverse(mat);
}
