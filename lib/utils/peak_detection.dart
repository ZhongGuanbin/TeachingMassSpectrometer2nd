/// 寻峰工具类
class PeakDetection {
  /// 来自https://github.com/anzhi998/findpeaks
  /// 等价于matlab中 findpeaks(sig,"minpeakdistance",distance)
  static List<int> findPeaks(List<double> src, {int distance = 0, int peakCounts = 20}) {
    int length = src.length;
    if (length <= 1) return [];

    List<int> sign = List.filled(length, -1);
    List<double> difference = List.filled(length, 0.0,growable: true);
    List<int> tempOut = [];

    /// first-order difference (sign)
    for (int i = 1; i < src.length; i++) {
      difference[i - 1] = src[i] - src[i - 1];
    }
    difference.removeAt(0);
    difference.removeLast();
    for (int i = 0; i < difference.length; ++i) {
      if (difference[i] >= 0) {
        sign[i] = 1;
      }
    }

    /// second-order difference
    for (int j = 1; j < length - 1; ++j) {
      int diff = sign[j] - sign[j - 1];
      if (diff < 0) {
        tempOut.add(j);
      }
    }

    if (tempOut.isEmpty) return tempOut;

    /// sort peaks from large to small by src value at peaks
    tempOut.sort((a, b) => src[b].compareTo(src[a]));

    if (distance == 0) {
      return tempOut.sublist(0, peakCounts > src.length ? src.length : peakCounts);
    }

    List<int> ans = [];
    //Initialize the answer and the collection to be excluded
    //ans.push_back(temp_out[0]);
    Map<int, int> except = {};
    ////    int left=temp_out[0]-distance>0? temp_out[0]-distance:0;
    ////    int right=temp_out[0]+distance>length-1? length-1:temp_out[0]+distance;
    //    int left=temp_out[0]-distance;
    //    int right=temp_out[0]+distance;
    //    for (int i = left;i<=right; ++i) {
    //        except.insert(i);
    //    }

    for (var it in tempOut) {
      if (!except.containsKey(it)) {
        //如果不在排除范围内
        ans.add(it);
        // update
        int left = it - distance > 0 ? it - distance : 0;
        int right = it + distance > length - 1 ? length - 1 : it + distance;
        for (int i = left; i <= right; ++i) {
          except[i] = (except[i] ?? 0) + 1;
        }
      }
    }

    ans.sort((a, b) => src[b].compareTo(src[a]));

    final ansWithCounts = peakCounts > ans.length ? ans : ans.sublist(0, peakCounts);

    // sort the ans from small to large by index value
    // ansWithCounts.sort();
    return ansWithCounts;
  }
}
