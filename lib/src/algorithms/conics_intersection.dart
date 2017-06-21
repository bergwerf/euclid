// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

/// An implementation of the intersection between two conics [E1] and [E2].
/// [E1] and [E2] are homogeneous conic matrices.
///
/// Copied from:
/// http://mathworks.com/matlabcentral/fileexchange/28318-conics-intersection
///
/// Which is:
/// Copyright (c) 2015, Pierluigi Taddei
/// All rights reserved.
// ignore: non_constant_identifier_names
List<Vector2> intersectConics(Matrix3 E1, Matrix3 E2) {
  final r1 = rank(E1);
  final r2 = rank(E2);
  final result = new List<Vector3>();

  if (r1 == 3 && r2 == 3) {
    result.addAll(_completeIntersection(E1, E2));
  } else if (r1 < 3 || r2 < 3) {
    // E2 or E3 is degenerate.
    final defE = r2 < 3 ? E2 : E1;
    final fullE = r2 < 3 ? E1 : E2;

    final lines = _decomposeDegenerateConic(defE, r2 < 3 ? r2 : r1);
    result.addAll(_intersectConicLine(fullE, lines.item1));
    result.addAll(_intersectConicLine(fullE, lines.item2));
  } else {
    throw new ArgumentError('E1 and E2 cannot be both degenerate');
  }

  // Convert results into cartesian coordinates.
  return result.map((v) => v.xy / v.z).toList();
}

/// Intersects two non-degenerate conics [E1] and [E2].
// ignore: non_constant_identifier_names
List<Vector3> _completeIntersection(Matrix3 E1, Matrix3 E2) {
  // ignore: non_constant_identifier_names
  final Matrix3 EE = E1 * inv3(-E2);
  final r = cubicRealRoots(
      -1,
      EE.trace(),
      -(mat2from3x3(EE, [0, 1], [0, 1]).determinant() +
          mat2from3x3(EE, [1, 2], [1, 2]).determinant() +
          mat2from3x3(EE, [0, 2], [0, 2]).determinant()),
      EE.determinant());

  if (r.isEmpty) {
    return [];
  } else {
    // ignore: non_constant_identifier_names
    final E0 = E1 + E2 * r.first;
    final lines = _decomposeDegenerateConic(E0, rank(E0));

    final result = new List<Vector3>();
    result.addAll(_intersectConicLine(E1, lines.item1));
    result.addAll(_intersectConicLine(E1, lines.item2));
    return result;
  }
}

/// Given a line [l] and a conic [C], detect the intersection points in
/// homogeneous coordinates.
List<Vector3> _intersectConicLine(Matrix3 C, Vector3 l) {
  final result = new List<Vector3>();
  final p = _getPointsOnLine(l);
  final p1 = p.item1, p2 = p.item2;

  // p1'Cp1 + 2k p1'Cp2 + k^2 p2'Cp2 = 0
  final p1Cp1 = vec3Txvec3(vec3TxMatrix3(p1, C), p1);
  final p2Cp2 = vec3Txvec3(vec3TxMatrix3(p2, C), p2);
  final p1Cp2 = vec3Txvec3(vec3TxMatrix3(p1, C), p2);

  if (p2Cp2 == 0) {
    // Linear
    final k1 = -.5 * p1Cp1 / p1Cp2;
    result.add(p1 + p2 * k1);
  } else {
    final delta = p1Cp2 * p1Cp2 - p1Cp1 * p2Cp2;
    if (delta >= 0) {
      final deltaSqrt = sqrt(delta);
      final k1 = (-p1Cp2 + deltaSqrt) / p2Cp2;
      final k2 = (-p1Cp2 - deltaSqrt) / p2Cp2;

      result.add(p1 + p2 * k1);
      result.add(p1 + p2 * k2);
    }
  }

  return result;
}

/// Given a homogeneous line [l], returns two homogenous points on it.
Tuple2<Vector3, Vector3> _getPointsOnLine(Vector3 l) {
  if (l.x == 0 && l.y == 0) {
    return new Tuple2<Vector3, Vector3>(vec3(1, 0, 0), vec3(0, 1, 0));
  } else {
    final p2 = vec3(-l.y, l.x, 0);
    final p1 = l.x.abs() < l.y.abs() ? vec3(0, -l.z, l.y) : vec3(-l.z, 0, l.x);
    return new Tuple2<Vector3, Vector3>(p1, p2);
  }
}

/// Decompose degenerate conic into two lines.
/// Returns homogeneous line coordinates.
Tuple2<Vector3, Vector3> _decomposeDegenerateConic(Matrix3 c, int rank) {
  //assert(rank == 1 || rank == 2);
  final C = c.clone();
  if (rank != 1) {
    // Use the dual conic of c.
    final B = -_adjointSym3(c);

    // Detect intersection point p.
    final d = diag3(c)..absolute();
    final maxV = maxN(d.storage);
    final di1 = d.storage.indexOf(maxV);
    if (B.entry(di1, di1) < 0) {
      return new Tuple2(null, null);
    }
    final b = sqrt(B.entry(di1, di1));
    final p = B.getColumn(di1) / b;

    // Detect lines product.
    final mp = _crossMatrix(p);
    C.add(mp);
  }

  // Recover lines.
  final maxV = maxN(C.storage);
  final ci1 = C.storage.indexOf(maxV);
  final j = (ci1 / 3).floor();
  final i = ci1 - j * 3;

  return new Tuple2<Vector3, Vector3>(C.getRow(i), C.getColumn(j));
}

/// Recover the 3x3 adjoint matrix of a 3x3 symmetric matrix [M].
Matrix3 _adjointSym3(Matrix3 M) {
  final A = new Matrix3.zero();
  final a = M.entry(0, 0), b = M.entry(0, 1), d = M.entry(0, 2);
  /*              */ final c = M.entry(1, 1), e = M.entry(1, 2);
  /*                                 */ final f = M.entry(2, 2);

  A.setEntry(0, 0, c * f - e * e);
  A.setEntry(0, 1, -b * f + e * d);
  A.setEntry(0, 2, b * e - c * d);

  A.setEntry(1, 0, A.entry(0, 1));
  A.setEntry(1, 1, a * f - d * d);
  A.setEntry(1, 2, -a * e + b * d);

  A.setEntry(2, 0, A.entry(0, 2));
  A.setEntry(2, 1, A.entry(1, 2));
  A.setEntry(2, 2, a * c - b * b);

  return A;
}

/// Given a homogeneous point [p], generates the skew symmetric matrix form used
/// in cross products: p x q -> Mp . q
Matrix3 _crossMatrix(Vector3 p) {
  final mp = new Matrix3.zero();
  mp.setEntry(0, 1, p.z);
  mp.setEntry(0, 2, -p.y);
  mp.setEntry(1, 0, -p.z);
  mp.setEntry(1, 2, p.x);
  mp.setEntry(2, 0, p.y);
  mp.setEntry(2, 1, -p.x);
  return mp;
}
