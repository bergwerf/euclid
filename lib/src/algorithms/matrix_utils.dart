// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

// Special types of matrix multiplication not covered in `vector_math`.
// Primarily the distinction between a vector and a transposed vector are
// important. It is up to the user to keep track of this distinction.

/// Multiply transposed Vector3 with Matrix3, returns transposed Vector3.
Vector3 vec3TxMatrix3(Vector3 vT, Matrix3 m) {
  return vec3(
      vT.dot(m.getColumn(0)), vT.dot(m.getColumn(1)), vT.dot(m.getColumn(2)));
}

/// Multiply transposed Vector3 with untransposed Vector3, returns scalar.
double vec3Txvec3(Vector3 vT, Vector3 v) {
  return vT.dot(v);
}

/// Get 2x2 matrix from 3x3 [matrix] in [rows] and [cols].
Matrix2 mat2from3x3(Matrix3 matrix, List<int> rows, List<int> cols) {
  return new Matrix2(
      matrix.entry(rows[0], cols[0]),
      matrix.entry(rows[0], cols[1]),
      matrix.entry(rows[1], cols[0]),
      matrix.entry(rows[1], cols[1]));
}
