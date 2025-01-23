class LocalNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  final bool? isAlarm;

  LocalNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.isAlarm,
  });
}