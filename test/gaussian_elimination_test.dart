// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:euclid/euclid.dart';

void main() {
  test('Matrix rank', () {
    expect(
        rank([
          [1, 2, 3],
          [2, 3, 5],
          [3, 4, 7],
          [4, 5, 9]
        ]),
        equals(2));

    expect(
        rank([
          [1, 2, 3],
          [0, 0, 0],
          [3, 4, 7],
          [4, 5, 9]
        ]),
        equals(2));

    expect(
        rank([
          [1, 0, 3, 4],
          [2, 0, 4, 5],
          [3, 0, 7, 9]
        ]),
        equals(2));
  });
}
