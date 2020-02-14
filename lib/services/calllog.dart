import 'package:call_log/call_log.dart';

class CallLogService {
  int lastcheck;
  Future<Iterable<CallLogEntry>> getCallsLastCheck() async {
    // GET WHOLE CALL LOG
    // Iterable<CallLogEntry> entries = await CallLog.get();

    // If did not check for a while, then check since last 24 hours
    lastcheck =
        DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
    int now = DateTime.now().subtract(Duration(days: 0)).millisecondsSinceEpoch;
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: lastcheck,
      dateTo: now,
    );
    return entries;
  }
}
