// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

/// Create conic section for ellipse with given [center], [semiAxes] and
/// rotated by [a].
ConicSection createEllipse(Vector2 center, Vector2 semiAxes, num a) {
  // Standard form: Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0
  // Centered ellipse with no rotation: x^2/a^2 + y^2/b^2 = 1
  // Substitute x = x cos(a) - y sin(a), y = x sin(a) + y cos(a) to rotate.
  // Substitute x = x - xt, y = y - yt to translate.
  // Simplify into standard form.

  final ax = semiAxes;
  final sna = sin(a), csa = cos(a);
  final xt = center.x, yt = center.y;

  final G = pow(csa, 2) / pow(ax.x, 2) + pow(sna, 2) / pow(ax.y, 2);
  final H = pow(sna, 2) / pow(ax.x, 2) + pow(csa, 2) / pow(ax.y, 2);
  final I = 2 * csa * sna / pow(ax.y, 2) - 2 * csa * sna / pow(ax.x, 2);

  return new ConicSection(
      // A: x^2
      G,
      // B: xy
      I,
      // C: y^2
      H,
      // D: x
      -2 * xt * G - yt * I,
      // E: y
      -2 * yt * H - xt * I,
      // F
      -1 + pow(xt, 2) * G + xt * yt * I + pow(yt, 2) * H);
}
