// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

// Quick class constructors

Vector2 vec2(num x, num y) => new Vector2(x.toDouble(), y.toDouble());
Vector3 vec3(num x, num y, num z) =>
    new Vector3(x.toDouble(), y.toDouble(), z.toDouble());
