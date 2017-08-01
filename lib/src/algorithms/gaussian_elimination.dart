// Copyright (c) 2017, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of euclid;

/// Swap [row1] and [row2] in [mat].
void _matrixSwap(List<List<double>> mat, int row1, int row2) {
  final row1list = mat[row1];
  mat[row1] = mat[row2];
  mat[row2] = row1list;
}

/// Compute rank of given [mat]. [mat] will be modified. [mat] is a
/// list of rows.
/// Based on: http://www.geeksforgeeks.org/program-for-rank-of-matrix/.
int _computeRank(List<List<double>> mat) {
  final R = mat.length; // Number of rows
  final C = mat[0].length; // Number of columns
  var rank = C; // We consider each column

  // Iterate through all columns.
  for (var col = 0; col < rank; col++) {
    // Check if diagonal element at [col] is non-zero.
    if (mat[col][col] != 0) {
      // Iterate through all column rows.
      for (var row = 0; row < R; row++) {
        // Make all column rows 0 except for mat[col][col].
        if (col != row) {
          final mult = mat[row][col] / mat[col][col];

          // Apply to all columns.
          for (var i = 0; i < rank; i++) {
            mat[row][i] -= mult * mat[col][i];
          }
        }
      }
    } else {
      // 1. Swap with other row that does have a non-zero value in this column.
      // 2. If all values below this column are 0, swap with the last row.
      var reduce = true;

      // Find the next non-zero element in current column.
      // Note that we start at the row after the column index.
      for (var i = col + 1; i < R; i++) {
        // Swap the row with the first non-zero element with this row.
        if (mat[i][col] != 0) {
          _matrixSwap(mat, col, i);
          reduce = false;
          break;
        }
      }

      // If we did not find any row with non-zero element in current columnm,
      // then all values in this column are 0.
      if (reduce) {
        // We can reduce the rank because this column does not have a pivot.
        rank--;

        // Copy the last column here. We don't have to swap since we won't be
        // processing the last column since we decremented [rank].
        for (var i = 0; i < R; i++) {
          mat[i][col] = mat[i][rank];
        }
      }

      // Process this column again
      col--;
    }
  }

  return rank;
}

/// Compute matrix rank.
int rank(mat) {
  if (mat is Matrix2) {
    return _computeRank([mat.row0.storage, mat.row1.storage]);
  } else if (mat is Matrix3) {
    return _computeRank([mat.row0.storage, mat.row1.storage, mat.row2.storage]);
  } else if (mat is Matrix4) {
    return _computeRank([
      mat.row0.storage,
      mat.row1.storage,
      mat.row2.storage,
      mat.row3.storage
    ]);
  } else if (mat is List) {
    return _computeRank(mat);
  } else {
    throw new UnimplementedError('unrecognized argument type');
  }
}
