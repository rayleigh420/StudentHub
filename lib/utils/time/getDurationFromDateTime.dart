class TimeUtil {
  static Duration getDurationFromDateTime(DateTime dateTime) {
    final Duration duration = DateTime.now().difference(dateTime);
    return duration;
  }
}
