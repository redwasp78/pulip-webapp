import 'package:flutter/material.dart';

/// 앱의 전역 상태를 관리하는 클래스
///
/// 다크모드, 알림 설정 등의 앱 전체 상태를 관리합니다.
class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isNotificationEnabled = true;

  /// 다크모드 상태
  bool get isDarkMode => _isDarkMode;

  /// 알림 허용 상태
  bool get isNotificationEnabled => _isNotificationEnabled;

  /// 다크모드 토글
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  /// 알림 설정 토글
  void toggleNotification() {
    _isNotificationEnabled = !_isNotificationEnabled;
    notifyListeners();
  }

  /// 다크모드 설정
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  /// 알림 설정
  void setNotification(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }
}

