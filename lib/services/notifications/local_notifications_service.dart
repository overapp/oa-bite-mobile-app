import 'package:bite/managers/bluetooth/bluetooth_manager.dart';
import 'package:bite/models/local_notifications/local_notifications.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/utils/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

/// Service to manage local notifications.
class LocalNotificationService {
  // Singleton instance of the service.
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();

  // The factory constructor returns the already existing instance, ensuring
  // that there are not multiple BluetoothManager objects floating around.
  factory LocalNotificationService() {
    return _instance;
  }

  // The private constructor is called only once to create the Singleton instance.
  LocalNotificationService._internal();

  // Instance of the Flutter Local Notifications Plugin.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Callback to refresh the screen after a notification action.
  Function? onRefreshScreen;

  /// Initializes the local notification service with platform-specific settings.
  Future<void> initialize() async {
    // Android Configuration
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    // iOS Configuration with custom settings
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
          'BITE TEST',
          actions: <DarwinNotificationAction>[
            // Creates a "simple" action called "Action 1". It has no special options, just a unique ID.
            DarwinNotificationAction.plain(
              'id_1',
              'Action 1',
            ),
            // Creates a "destructive" action called "Action 2". The destructive option is usually used for actions that result in data loss or significant changes (for example, "Delete" or "Undo").
            DarwinNotificationAction.plain(
              'id_2',
              'Action 2',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            // Create an action called "Action 3" that will launch the foreground app when selected.
            DarwinNotificationAction.plain(
              'id_3',
              'Action 3',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            // Indicates that the notification title should be shown even when the notification is in "hidden preview" mode
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );

    // Main Configuration
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // Request notification permissions from the user.
    await requestNotificationPermissions();

    // Initialize the plugin with the provided settings.
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // Callback for foreground notifications.
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      // Callback for background notifications.
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  /// Handles user interaction with a notification in the foreground.
  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      BiteLogger().warning('notification payload: $payload');

      final goRouter = GoRouter.of(rootNavigatorKey.currentContext!);

      BluetoothManager().dispose();

      final shouldReload = await goRouter.pushNamed(
        Routes.poiDetailById,
        extra: {
          'externalId': payload,
        },
      );

      if (shouldReload == true) {
        BiteLogger().info('POPPED TRUE');

        if (onRefreshScreen != null) {
          onRefreshScreen!();
        }
      }
    }
  }

  /// Handles user interaction with a backgroud notifications.
  //@pragma('vm:entry-point')
  static void onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    BiteLogger()
        .warning('notification(${notificationResponse.id}) action tapped: '
            '${notificationResponse.actionId} with'
            ' payload: ${notificationResponse.payload}');
  }

  /// Displays a notification to the user.
  Future<void> showNotification(LocalNotification notification,
      {Function? onPoppedTrue}) async {
    // Android-specific notification details.
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    // iOS-specific notification details.
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    // Show the notification with the provided details.
    await _flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: notification.payload,
    );

    // Set a callback to refresh the screen.
    if (onPoppedTrue != null) {
      onRefreshScreen = onPoppedTrue;
    }
  }

  // Show alert for notification permission
  Future<void> requestNotificationPermissions() async {
    final bool? granted = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted == null || !granted) {
      BiteLogger().warning("Notification permissions not granted");
    }
  }

  // Method to get notification permission allowed iOS
  Future<bool?> verifyPermission() async {
    final result = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    return result;
  }
}
