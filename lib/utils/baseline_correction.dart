import 'dart:math';

/// 基线校准类
class BaselineCorrection {
  double _minFun(double a, double b) {
    return (a > b) ? b : a;
  }

  double _maxFun(double a, double b) {
    return (a > b) ? a : b;
  }

  List<double> process(List<double> vdIntensity, int bcWinSize) {
    return _removeBaseline(vdIntensity, bcWinSize);
  }

  List<double> _removeBaseline(List<double> input, int winSize) {
    int n = input.length;
    List<double> output = List<double>.filled(n, 0.0);
    List<double> erodedLine = _erode(input, winSize); // 腐蚀
    erodedLine[0] = input.first;
    erodedLine[n - 1] = input.last;

    List<double> dilatedLine = _dilate(erodedLine, winSize); // 膨胀
    for (int i = 0; i < n; i++) {
      output[i] = max(0.0, input[i] - dilatedLine[i]);
    }
    return output;
  }

  List<double> _erode(List<double> input, int winSize) {
    return _morphology(input, winSize, _minFun);
  }

  List<double> _dilate(List<double> input, int winSize) {
    return _morphology(input, winSize, _maxFun);
  }

  List<double> _morphology(List<double> input, int winSize,
      double Function(double, double) minMaxFun) {
    int n = input.length;
    int q = winSize ~/ 2;
    int k = 2 * q + 1;
    int fn = n + 2 * q + (k - (n % k));
    List<double> f = List<double>.filled(fn, 0.0);
    List<double> g = List<double>.filled(fn, 0.0);
    List<double> h = List<double>.filled(fn, 0.0);

    for (int i = 0; i < n; i++) {
      f[i + q] = input[i];
    }
    for (int i = 0; i < q; i++) {
      f[i] = f[q];
      h[i] = f[q];
    }

    /* init right extrema */
    for (int i = n + q; i < fn; i++) {
      f[i] = f[n + q - 1];
      g[i] = f[n + q - 1];
    }

    /* preprocessing */
    for (int i = q, r = i + k - 1; i < n + q; i += k, r += k) {
      /* init most left/right elements */
      g[i] = f[i];
      h[r] = f[r];
      for (int j = 1, gi = i + 1, hi = r - 1; j < k; j++, gi++, hi--) {
        g[gi] = minMaxFun(g[gi - 1], f[gi]);
        h[hi] = minMaxFun(h[hi + 1], f[hi]);
      }
    }

    /* merging */
    List<double> output = List<double>.filled(n, 0.0);
    for (int gi = k - 1, hi = 0; hi < n; gi++, hi++) {
      output[hi] = minMaxFun(g[gi], h[hi]);
    }
    return output;
  }
}
