import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'savitzky_golay_smoother.dart';

class SGTest {
  static void main(final List<String> args) {
    final files = Directory.current.listSync();
    for (final f in files) {
      if (f.path.toLowerCase().endsWith(".csv") &&
          !f.path.toLowerCase().endsWith("_sm.csv")) {
        smoothData(f.path);
      }
    }
  }

  static void smoothData(final String f) {
    debugPrint("Smoothing data in $f");
    final List<String> lines = [];
    final gbkStream = File(f).openRead();
    gbkStream
        .transform(const SystemEncoding().decoder)
        .transform(const LineSplitter())
        .listen((line) {
      lines.add(line);
    }).onDone(() {
      // final List<String> lines = File(f).readAsLinesSync();
      if (lines.length > 1) {
        final List<double> x = List<double>.filled(lines.length - 1, 0);
        final List<double> y = List<double>.filled(lines.length - 1, 0);
        for (int i = 1; i < lines.length; i++) {
          final List<String> ss = lines[i].split(',');
          if (ss.length > 1) {
            x[i - 1] = double.parse(ss[0]);
            y[i - 1] = double.parse(ss[1]);
          }
        }

        // Smooth the data with a window size of 15, polynomial of 3, and 2 times
        final List<double> smoothedY =
            SavitzkyGolaySmoother.smooth(x, y, 15, 3, 2);

        final StringBuffer sb = StringBuffer();
        sb.writeln(lines[0]);
        for (int i = 0; i < x.length; i++) {
          sb.writeln('${x[i]},${smoothedY[i]}');
        }
        final smoothedF = f.replaceFirst('.csv', '_sm.csv');
        File(smoothedF).writeAsStringSync(sb.toString());
        debugPrint('Smoothed data saved in $smoothedF');
      }
    });
  }
}
