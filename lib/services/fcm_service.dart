import 'dart:async';
import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Firebase Cloud Messaging 서비스
///
/// 푸시 알림의 초기화, 토큰 관리, 메시지 처리를 담당합니다.
/// 백그라운드 및 포그라운드 알림을 모두 지원합니다.
class FCMService {
  // static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? _fcmToken;
  // static StreamSubscription<RemoteMessage>? _messageSubscription;

  /// FCM 서비스 초기화
  static Future<void> initialize() async {
    try {
      // Firebase가 초기화되었는지 확인
      if (Firebase.apps.isEmpty) {
        throw Exception('Firebase not initialized');
      }

      // 알림 권한 요청
      await _requestPermission();

      // FCM 토큰 가져오기
      await _getFCMToken();

      // 포그라운드 메시지 리스너 설정
      _setupForegroundMessageListener();

      // 백그라운드 메시지 핸들러 설정
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      // 알림 클릭 시 앱 열기 처리
      _handleNotificationTap();

      if (kDebugMode) {
        print('FCM Service initialized successfully');
        print('FCM Token: $_fcmToken');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FCM Service initialization failed: $e - 앱은 정상 작동합니다');
      }
      // FCM 초기화 실패해도 앱은 정상 작동
      rethrow; // main.dart에서 catch하도록
    }
  }

  /// 알림 권한 요청
  static Future<void> _requestPermission() async {
    // Firebase 기능 임시 비활성화
    if (kDebugMode) {
      print('Permission request disabled (Firebase temporarily disabled)');
    }
    
    // final settings = await _messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // if (kDebugMode) {
    //   print('Permission granted: ${settings.authorizationStatus}');
    // }
  }

  /// FCM 토큰 가져오기
  static Future<void> _getFCMToken() async {
    try {
      // Firebase 기능 임시 비활성화
      if (kDebugMode) {
        print('FCM token retrieval disabled (Firebase temporarily disabled)');
      }
      
      // _fcmToken = await _messaging.getToken();

      // // 토큰 갱신 리스너 설정
      // _messaging.onTokenRefresh.listen((newToken) {
      //   _fcmToken = newToken;
      //   if (kDebugMode) {
      //     print('FCM Token refreshed: $newToken');
      //   }
      //   // 서버에 새 토큰 전송 로직 추가 가능
      // });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get FCM token: $e');
      }
    }
  }

  /// 포그라운드 메시지 리스너 설정
  static void _setupForegroundMessageListener() {
    // Firebase 기능 임시 비활성화
    if (kDebugMode) {
      print('Foreground message listener disabled (Firebase temporarily disabled)');
    }
    
    // _messageSubscription =
    //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (kDebugMode) {
    //     print('Received foreground message: ${message.messageId}');
    //     print('Title: ${message.notification?.title}');
    //     print('Body: ${message.notification?.body}');
    //     print('Data: ${message.data}');
    //   }

    //   // 포그라운드에서 알림 표시
    //   _showForegroundNotification(message);
    // });
  }

  /// 포그라운드 알림 표시
  static void _showForegroundNotification(dynamic message) {
    // Flutter Local Notifications를 사용하여 포그라운드 알림 표시
    // 현재는 로그만 출력
    if (kDebugMode) {
      print('Showing foreground notification disabled (Firebase temporarily disabled)');
    }
  }

  /// 알림 클릭 시 앱 열기 처리
  static void _handleNotificationTap() {
    // Firebase 기능 임시 비활성화
    if (kDebugMode) {
      print('Notification tap handling disabled (Firebase temporarily disabled)');
    }
    
    // // 앱이 종료된 상태에서 알림 클릭 시
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   if (kDebugMode) {
    //     print('Notification tapped: ${message.messageId}');
    //     print('Data: ${message.data}');
    //   }

    //   // 알림 데이터에 따라 WebView URL 변경
    //   _handleNotificationNavigation(message.data);
    // });

    // // 앱이 백그라운드 상태에서 알림 클릭 시
    // _messaging.getInitialMessage().then((RemoteMessage? message) {
    //   if (message != null) {
    //     if (kDebugMode) {
    //       print('App opened from notification: ${message.messageId}');
    //       print('Data: ${message.data}');
    //     }

    //     _handleNotificationNavigation(message.data);
    //   }
    // });
  }

  /// 알림 클릭 시 네비게이션 처리
  static void _handleNotificationNavigation(Map<String, dynamic> data) {
    final String? targetUrl = data['url'];
    if (targetUrl != null) {
      // WebView로 특정 URL 이동
      // Navigator를 사용하여 WebView 화면으로 이동
      if (kDebugMode) {
        print('Navigating to URL: $targetUrl');
      }
    }
  }

  /// FCM 토큰 반환
  static String? get fcmToken => _fcmToken;

  /// 디바이스 정보 가져오기 (임시 주석 처리)
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    // final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      // final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return {
        'platform': 'android',
        'model': 'Unknown',
        'version': 'Unknown',
        'sdkInt': 0,
      };
    } else if (Platform.isIOS) {
      // final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return {
        'platform': 'ios',
        'model': 'Unknown',
        'version': 'Unknown',
        'name': 'Unknown',
      };
    }

    return {'platform': 'unknown'};
  }

  /// 서비스 정리
  static void dispose() {
    _messageSubscription?.cancel();
    if (kDebugMode) {
      print('FCM Service disposed');
    }
  }
}

/// 백그라운드 메시지 핸들러
/// 앱이 백그라운드에 있을 때 호출됩니다.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase 초기화
  await Firebase.initializeApp();

  if (kDebugMode) {
    print('Handling background message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');
  }
}
