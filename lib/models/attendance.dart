class AttendanceRecord {
  final bool lateEntry;
  final bool earlyExit;
  final String? timeIn;
  final String? timeOut;

  AttendanceRecord({
    required this.lateEntry,
    required this.earlyExit,
    this.timeIn,
    this.timeOut,
  });
}