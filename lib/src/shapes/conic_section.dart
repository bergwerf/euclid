// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

class ConicSection {
  final num A, B, C, D, E, F;

  ConicSection(this.A, this.B, this.C, this.D, this.E, this.F);

  /// |  A  B/2 D/2 |
  /// | B/2  C  E/2 |
  /// | D/2 E/2  F  |
  Matrix3 get homogeneousMatrix =>
      new Matrix3(A, B / 2, D / 2, B / 2, C, E / 2, D / 2, E / 2, F);

  @override
  String toString() => '${A}x^2 + ${B}xy + ${C}y^2 + ${D}x + ${E}y + ${F} = 0';
}
