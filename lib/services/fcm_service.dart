import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Firebase Cloud Messaging 서비스
/// 
/// 푸시 알림의 초기화, 토큰 관리, 메시지 처리를 담당합니다.
class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? _fcmToken;
  static String? _initialMessage;

  /// FCM 서비스 초기화
  static Future<void> initialize() async {
    // 알림 권한 요청
    await _requestPermission();
    
    // FCM 토큰 가져오기
    await _getFCMToken();
    
    // 메시지 핸들러 설정
    _setupMessageHandlers();
    
    // 백그라운드에서 앱이 시작된 경우 처리
    await _handleInitialMessage();
  }

  /// 알림 권한 요청
  static Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('사용자가 알림 권한을 허용했습니다.');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('사용자가 임시 알림 권한을 허용했습니다.');
    } else {
      debugPrint('사용자가 알림 권한을 거부했습니다.');
    }
  }

  /// FCM 토큰 가져오기
  static Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $_fcmToken');
      
      // 토큰을 SharedPreferences에 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', _fcmToken ?? '');
      
      // 토큰 갱신 리스너 설정
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        _saveTokenToPreferences(token);
      });
    } catch (e) {
      debugPrint('FCM 토큰 가져오기 오류: $e');
    }
  }

  /// 토큰을 SharedPreferences에 저장
  static Future<void> _saveTokenToPreferences(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
    debugPrint('FCM 토큰이 갱신되었습니다: $token');
  }

  /// 메시지 핸들러 설정
  static void _setupMessageHandlers() {
    // 포그라운드 메시지 처리
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('포그라운드 메시지 수신: ${message.notification?.title}');
      _handleForegroundMessage(message);
    });

    // 백그라운드 메시지 처리 (앱이 백그라운드에 있거나 종료된 상태)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('백그라운드 메시지 클릭: ${message.notification?.title}');
      _handleBackgroundMessage(message);
    });
  }

  /// 초기 메시지 처리 (앱이 백그라운드에서 시작된 경우)
  static Future<void> _handleInitialMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _initialMessage = initialMessage.data.toString();
      debugPrint('초기 메시지: $_initialMessage');
      _handleBackgroundMessage(initialMessage);
    }
  }

  /// 포그라운드 메시지 처리
  static void _handleForegroundMessage(RemoteMessage message) {
    // 포그라운드에서는 직접 알림을 표시할 수 없으므로
    // 앱 내에서 알림을 처리해야 합니다.
    if (message.notification != null) {
      final title = message.notification!.title ?? '알림';
      final body = message.notification!.body ?? '';
      
      // 앱 내 알림 표시 로직
      _showInAppNotification(title, body);
    }
  }

  /// 백그라운드 메시지 처리
  static void _handleBackgroundMessage(RemoteMessage message) {
    // 메시지 데이터에서 URL 추출
    final url = message.data['url'] ?? message.data['target_url'];
    
    if (url != null) {
      // WebView로 특정 URL 이동
      _navigateToUrl(url);
    }
  }

  /// 앱 내 알림 표시
  static void _showInAppNotification(String title, String body) {
    // 실제 구현에서는 GlobalKey를 통해 현재 화면에 스낵바 표시
    debugPrint('앱 내 알림: $title - $body');
  }

  /// URL로 네비게이션
  static void _navigateToUrl(String url) {
    // 실제 구현에서는 Navigator를 통해 WebView로 이동
    debugPrint('알림 클릭으로 이동할 URL: $url');
  }

  /// FCM 토큰 반환
  static String? get fcmToken => _fcmToken;

  /// 초기 메시지 반환
  static String? get initialMessage => _initialMessage;

  /// 토픽 구독
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('토픽 구독 성공: $topic');
    } catch (e) {
      debugPrint('토픽 구독 오류: $e');
    }
  }

  /// 토픽 구독 해제
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('토픽 구독 해제 성공: $topic');
    } catch (e) {
      debugPrint('토픽 구독 해제 오류: $e');
    }
  }

  /// 저장된 FCM 토큰 가져오기
  static Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  /// 알림 설정 확인
  static Future<bool> isNotificationEnabled() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
           settings.authorizationStatus == AuthorizationStatus.provisional;
  }
}

/// 백그라운드 메시지 핸들러 (최상위 레벨 함수)
/// 
/// 앱이 백그라운드에서 실행 중일 때 메시지를 처리합니다.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('백그라운드 메시지 처리: ${message.messageId}');
  debugPrint('메시지 데이터: ${message.data}');
}
