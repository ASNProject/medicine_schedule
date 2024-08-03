import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ));

    tz.initializeTimeZones();
  }

  static Future<void> scheduledNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
      'Important_notifications',
      'My Channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iosDetails = const DarwinNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notification.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // void scheduleAlarm() {
  //   AndroidAlarmManager.periodic(const Duration(minutes: 1), 0, checkSchedule,
  //       exact: true, wakeup: true);
  // }
  //
  // void checkSchedule() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> scheduleList = prefs.getStringList('schedules') ?? [];
  //   List<ScheduleModel> schedules =
  //   scheduleList.map((e) => ScheduleModel.fromJson(json.decode(e))).toList();
  //
  //   final now = tz.TZDateTime.now(tz.getLocation('Asia/Jakarta'));
  //
  //   for (var schedule in schedules) {
  //     final dayIndex = _dayToIndex(schedule.day);
  //     final scheduleTime = parseAndFormatTimeOfDayString(schedule.time);
  //     final scheduleHour = int.parse(scheduleTime.split(':')[0]);
  //     final scheduleMinute = int.parse(scheduleTime.split(':')[1]);
  //
  //     if (dayIndex == now.weekday) {
  //       if (scheduleHour == now.hour && scheduleMinute == now.minute) {
  //         flutterLocalNotificationsPlugin.show(
  //           0,
  //           'Jadwal Obat',
  //           // 'Waktunya minum obat: ${schedule.medicineName}',
  //           'Waktunya minum obat',
  //           const NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               'your_channel_id',
  //               'your_channel_name',
  //               importance: Importance.max,
  //               priority: Priority.high,
  //               showWhen: false,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }
  //
  // int _dayToIndex(String day) {
  //   switch (day.toLowerCase()) {
  //     case 'Senin':
  //       return 1;
  //     case 'Selasa':
  //       return 2;
  //     case 'Rabu':
  //       return 3;
  //     case 'Kamis':
  //       return 4;
  //     case "Jum'at":
  //       return 5;
  //     case 'Sabtu':
  //       return 6;
  //     case 'Minggu':
  //       return 7;
  //     default:
  //       return 1;
  //   }
  // }
}
