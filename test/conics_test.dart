// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:euclid/euclid.dart';

void main() {
  test('Ellipse-ellipse intersection using conics', () {
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

    expect(ab[0], equals(vec2(3.0701329708099365, 2.5090177059173584)));
    expect(ab[1], equals(vec2(5.480583190917969, 5.192071437835693)));
    expect(ab[2], equals(vec2(9.246254920959473, 4.677626132965088)));
    expect(ab[3], equals(vec2(5.569156169891357, 1.3882912397384644)));

    expect(ac[0], equals(vec2(6.448883056640625, 1.5661028623580933)));
    expect(ac[1], equals(vec2(3.8758091926574707, 1.5801531076431274)));
    expect(ac[2], equals(vec2(5.918144226074219, 5.34121036529541)));
    expect(ac[3], equals(vec2(3.3073794841766357, 3.5332531929016113)));

    expect(bc[0], equals(vec2(5.519637107849121, 5.760215759277344)));
    expect(bc[1], equals(vec2(3.4399678707122803, 2.6601574420928955)));
    expect(bc[2], equals(vec2(6.620107650756836, 3.5789835453033447)));
    expect(bc[3], equals(vec2(5.5202412605285645, 0.6001520156860352)));

    // Values are valid, see: https://www.desmos.com/calculator/kkjjxpsnvd.
  });

  test('Ellipse conic construction', () {
    final ellipse = createEllipse(vec2(2, 2), vec2(1, 3), -3.1415 / 6);

    expect(ellipse.A, equals(0.777789665132905));
    expect(ellipse.B, equals(-0.7697866320946175));
    expect(ellipse.C, equals(0.33332144597820607));
    expect(ellipse.D, equals(-1.5715853963423851));
    expect(ellipse.E, equals(0.20628748027641075));
    expect(ellipse.F, equals(0.3652979160659744));
  });

  test('Line conic construction', () {
    final line = createLineConic(vec2(3, 3), vec2(1, -1));

    expect(line.A, equals(0));
    expect(line.B, equals(0));
    expect(line.C, equals(0));
    expect(line.D, equals(-1));
    expect(line.E, equals(-1));
    expect(line.F, equals(6));
  });

  test('Circle-line intersection using conics', () {
    final line = createLineConic(vec2(0, 0), vec2(1, 1));
    final circ = createEllipse(vec2(0, 0), vec2(1, 1), 0);
    final out = intersectConics(circ.homogeneousMatrix, line.homogeneousMatrix);

    expect(out[0], equals(vec2(0.7071067690849304, 0.7071067690849304)));
    expect(out[1], equals(vec2(-0.7071067690849304, -0.7071067690849304)));
  });

  test('Ellipse-line intersection using conics', () {
    final line = createLineConic(vec2(3, 1), vec2(1, -1));
    final ell = createEllipse(vec2(1, 1), vec2(2, 1), 1);
    final out = intersectConics(line.homogeneousMatrix, ell.homogeneousMatrix);

    expect(out[0], equals(vec2(1.3387603759765625, 2.6612396240234375)));
    expect(out[1], equals(vec2(2.3381400108337402, 1.6618601083755493)));
  });
}
