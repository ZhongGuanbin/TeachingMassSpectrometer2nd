// https://github.com/vaccovecrana/savitzky-golay
// Licensed under the Apache License, Version 2.0 (the "License");

import 'dart:math';

import 'sg_smoother_utils.dart';


class SavitzkyGolaySmoother {
  int windowSize;
  int derivative;
  late final List<List<double>> weights;

  SavitzkyGolaySmoother._(this.windowSize, this.derivative, int polynomial) {
    windowSize = ((max(5, windowSize) ~/ 2) * 2) + 1;
    derivative = max(0, derivative);
    polynomial = max(2, polynomial);
    weights = SgSmootherUtils.computeWeights(windowSize, polynomial, derivative);
  }

  static List<double> smooth(final List<double> x, final List<double> y, final int windowSize,
      final int polynomial, int times) {
    if ((y.length < 5) || (y.length != x.length) || ((windowSize * 2) >= y.length)) {
      return y;
    }
    times = min(5, max(1, times));
    final SavitzkyGolaySmoother smoother = SavitzkyGolaySmoother._(windowSize, 0, polynomial);
    List<double> out = y;
    for (int i = 0; i < times; i++) {
      out = smoother.process(out, x);
    }
    return out;
  }

  double getHs(final List<double> h, final int center, final int half, final int derivative) {
    double hs = 0;
    int count = 0;
    for (int i = center - half; i < (center + half); i++) {
      if ((i >= 0) && (i < (h.length - 1))) {
        hs += h[i + 1] - h[i];
        count++;
      }
    }
    return pow(hs / count, derivative).toDouble();
  }

  List<double> process(final List<double> data, final List<double> h) {
    final int halfWindow = (windowSize / 2.0).floor();
    final int numPoints = data.length;
    double hs;
    final List<double> out = List.filled(numPoints, 0);
    // For the borders
    for (int i = 0; i < halfWindow; i++) {
      final List<double> wg1 = weights[halfWindow - i - 1];
      final List<double> wg2 = weights[halfWindow + i + 1];
      double d1 = 0;
      double d2 = 0;
      for (int l = 0; l < windowSize; l++) {
        d1 += wg1[l] * data[l];
        d2 += wg2[l] * data[(numPoints - windowSize) + l];
      }
      hs = getHs(h, halfWindow - i - 1, halfWindow, derivative);
      out[halfWindow - i - 1] = d1 / hs;
      hs = getHs(h, (numPoints - halfWindow) + i, halfWindow, derivative);
      out[(numPoints - halfWindow) + i] = d2 / hs;
    }

    // For the internal points
    final wg = weights[halfWindow];
    for (int i = windowSize; i <= numPoints; i++) {
      double d = 0;
      for (int l = 0; l < windowSize; l++) {
        d += wg[l] * data[(l + i) - windowSize];
      }
      hs = getHs(h, i - halfWindow - 1, halfWindow, derivative);
      out[i - halfWindow - 1] = d / hs;
    }
    return out;
  }
}
