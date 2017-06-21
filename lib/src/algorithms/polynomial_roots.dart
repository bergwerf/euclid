// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

/// Find roots of the cubic polynomial given by [a]x^3+[b]x^2+[c]x+[d]=0.
/// From: https://stackoverflow.com/questions/27176423/.
List<num> cubicRealRoots(num a, num b, num c, num d) {
  const eps = 1e-8;

  if (a.abs() < eps) {
    // Quadratic case: bx^2+cx+d=0
    if (b.abs() < eps) {
      // Linear case: cx+d=0
      return a == 0 ? [] : [-d / c];
    }

    // Apply abc formula.
    final D = c * c - 4 * b * d;
    if (D.abs() < eps) {
      return [-c / (2 * b)];
    } else if (D > 0) {
      return [(-c + sqrt(D)) / (2 * b), (-c - sqrt(D)) / (2 * b)];
    } else {
      return [];
    }
  }

  // Convert to depressed cubic t^3+pt+q = 0 (subst x = t - b/3a)
  final p = (3 * a * c - b * b) / (3 * a * a);
  final q = (2 * b * b * b - 9 * a * b * c + 27 * a * a * d) / (27 * a * a * a);
  final roots = new List<num>();

  if (p.abs() < eps) {
    // p = 0 -> t^3 = -q -> t = -q^1/3
    roots.add(cbrt(-q));
  } else if (q.abs() < 1e-8) {
    // q = 0 -> t^3 + pt = 0 -> t(t^2+p)=0
    roots.add(0);
    if (p < 0) {
      roots.addAll([sqrt(-p), -sqrt(-p)]);
    }
  } else {
    final D = q * q / 4 + p * p * p / 27;
    if (D.abs() < 1e-8) {
      // D = 0 -> two roots
      roots.addAll([-1.5 * q / p, 3 * q / p]);
    } else if (D > 0) {
      // Only one real root
      final u = cbrt(-q / 2 - sqrt(D));
      roots.add(u - p / (3 * u));
    } else {
      // D < 0, three roots, we use complex numbers/trigonometric solution.
      final u = 2 * sqrt(-p / 3);
      // D < 0 implies p < 0 and acos argument in [-1..1].
      final t = acos(3 * q / p / u) / 3;
      final k = 2 * PI / 3;
      roots.addAll([u * cos(t), u * cos(t - k), u * cos(t - 2 * k)]);
    }
  }

  // Convert back from depressed cubic
  for (var i = 0; i < roots.length; i++) {
    roots[i] -= b / (3 * a);
  }

  return roots;
}

/// Cubix root of [x].
num cbrt(x) {
  final y = pow(x.abs(), 1 / 3);
  return x < 0 ? -y : y;
}
