/// SG平滑帮助类
class SgSmootherUtils {
  static List<List<double>> computeWeights(int windowSize, int polynomial, int derivative) {
    final List<List<double>> weights =
        List.generate(windowSize, (i) => List<double>.filled(windowSize, 0));
    final int windowMiddle = (windowSize / 2.0).floor();

    for (int row = -windowMiddle; row <= windowMiddle; row++) {
      for (int col = -windowMiddle; col <= windowMiddle; col++) {
        weights[row + windowMiddle][col + windowMiddle] =
            polyWeight(col, row, windowMiddle, polynomial, derivative);
      }
    }

    return weights;
  }

  static double gramPolynomial(int i, int m, int k, int s) {
    double result;
    if (k > 0) {
      final double t0 = (4 * k) - 2;
      final double t1 = k * (((2 * m) - k) + 1);
      final double t2 = t0 / t1;

      final double t3 = i * gramPolynomial(i, m, k - 1, s);
      final double t4 = s * gramPolynomial(i, m, k - 1, s - 1);

      final int t5 = (k - 1) * ((2 * m) + k);
      final double t6 = k * (((2 * m) - k) + 1);
      final double t7 = t5 / t6;

      final double t8 = gramPolynomial(i, m, k - 2, s);

      result = (t2 * (t3 + t4)) - (t7 * t8);
    } else if ((k == 0) && (s == 0)) {
      result = 1;
    } else {
      result = 0;
    }
    return result;
  }

  static double polyWeight(int i, int t, int windowMiddle, int polynomial, int derivative) {
    double sum = 0;
    for (int k = 0; k <= polynomial; k++) {
      final double t0 = (2 * k) + 1;
      final int t1 = productOfRange(2 * windowMiddle, k);
      final int t2 = productOfRange((2 * windowMiddle) + k + 1, k + 1);
      final double t3 = gramPolynomial(i, windowMiddle, k, 0);
      final double t4 = gramPolynomial(t, windowMiddle, k, derivative);
      sum += t0 * (t1 / t2) * t3 * t4;
    }
    return sum;
  }

  static int productOfRange(int a, int b) {
    int gf = 1;
    if (a >= b) {
      for (int j = (a - b) + 1; j <= a; j++) {
        gf *= j;
      }
    }
    return gf;
  }
}
