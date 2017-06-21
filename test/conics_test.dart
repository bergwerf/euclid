// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:euclid/euclid.dart';

void main() {
  test('Conic intersections', () {
    final a =
        new ConicSection(-349.9, 377.59, -785.68, 3032.65, 3093.44, -11736.67);
    final b =
        new ConicSection(-100.13, 272.09, -7.59, 196.76, -1453.65, 1938.82);
    final c =
        new ConicSection(-490.81, -99.46, -184.08, 5227.35, 1719.77, -14536.06);

    final ab = intersectConics(a.homogeneousMatrix, b.homogeneousMatrix);
    final ac = intersectConics(a.homogeneousMatrix, c.homogeneousMatrix);
    final bc = intersectConics(b.homogeneousMatrix, c.homogeneousMatrix);

    expect(ab.length, equals(4));
    expect(ac.length, equals(4));
    expect(bc.length, equals(4));

    expect(ab[0], equals(vec2(9.246224403381348, 4.67769193649292)));
    expect(ab[1], equals(vec2(5.56899881362915, 1.3882734775543213)));
    expect(ab[2], equals(vec2(3.070133924484253, 2.5090131759643555)));
    expect(ab[3], equals(vec2(5.4805474281311035, 5.1920576095581055)));

    expect(ac[0], equals(vec2(6.448883056640625, 1.5661029815673828)));
    expect(ac[1], equals(vec2(3.8758091926574707, 1.5801533460617065)));
    expect(ac[2], equals(vec2(5.918144226074219, 5.34121036529541)));
    expect(ac[3], equals(vec2(3.3073794841766357, 3.5332531929016113)));

    expect(bc[0], equals(vec2(5.519636154174805, 5.760214328765869)));
    expect(bc[1], equals(vec2(3.4399685859680176, 2.660158157348633)));
    expect(bc[2], equals(vec2(6.620107173919678, 3.5789847373962402)));
    expect(bc[3], equals(vec2(5.520240783691406, 0.6001523733139038)));

    // Values are valid, see: https://www.desmos.com/calculator/kkjjxpsnvd.
  });

  test('Ellipse construction', () {
    final ellipse = createEllipse(vec2(2, 2), vec2(1, 3), -3.1415 / 6);

    expect(ellipse.A, equals(0.777789665132905));
    expect(ellipse.B, equals(-0.7697866320946175));
    expect(ellipse.C, equals(0.33332144597820607));
    expect(ellipse.D, equals(-1.5715853963423851));
    expect(ellipse.E, equals(0.20628748027641075));
    expect(ellipse.F, equals(0.3652979160659744));
  });
}
