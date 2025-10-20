import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 네비게이션 유틸리티
///
/// 뒤로가기, 외부 링크 처리, URL 런칭 등의 네비게이션 관련 기능을 제공합니다.
class NavigationUtils {
  /// 뒤로가기 버튼 처리
  ///
  /// Android의 하드웨어 뒤로가기 버튼과 iOS의 제스처를 처리합니다.
  static Future<bool> handleBackButton(
    BuildContext context,
    bool canGoBack,
    VoidCallback? onBackPressed,
  ) async {
    // WebView에서 뒤로가기가 가능한 경우
    if (canGoBack && onBackPressed != null) {
      onBackPressed();
      return false; // 기본 뒤로가기 동작 방지
    }

    // 뒤로가기가 불가능한 경우 앱 종료 확인
    return await _showExitDialog(context);
  }

  /// 앱 종료 확인 다이얼로그 표시
  static Future<bool> _showExitDialog(BuildContext context) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('앱 종료'),
        content: const Text('앱을 종료하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('종료'),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  /// 외부 URL 실행
  ///
  /// 전화, 이메일, SMS, 웹 브라우저 등을 실행합니다.
  static Future<bool> launchExternalUrl(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: mode);
        return true;
      } else {
        debugPrint('URL 실행 불가: $url');
        return false;
      }
    } catch (e) {
      debugPrint('URL 실행 오류: $e');
      return false;
    }
  }

  /// 전화번호 실행
  static Future<bool> makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    return await launchExternalUrl(url);
  }

  /// 이메일 작성 실행
  static Future<bool> sendEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final Map<String, String> params = {};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;

    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(params),
    );

    return await launchExternalUrl(uri.toString());
  }

  /// SMS 전송 실행
  static Future<bool> sendSMS(String phoneNumber, {String? message}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      query: message != null ? 'body=$message' : null,
    );

    return await launchExternalUrl(uri.toString());
  }

  /// URL 쿼리 파라미터 인코딩
  static String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  /// 웹 브라우저에서 URL 열기
  static Future<bool> openInBrowser(String url) async {
    return await launchExternalUrl(url, mode: LaunchMode.externalApplication);
  }

  /// 외부 앱에서 URL 열기
  static Future<bool> openInExternalApp(String url) async {
    return await launchExternalUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
  }

  /// WebView 내에서 URL이 외부 링크인지 확인
  static bool isExternalLink(String url, String currentHost) {
    try {
      final uri = Uri.parse(url);
      final currentUri = Uri.parse(currentHost);

      // 다른 도메인이거나 특정 프로토콜인 경우 외부 링크로 처리
      return uri.host != currentUri.host ||
          uri.scheme == 'tel' ||
          uri.scheme == 'mailto' ||
          uri.scheme == 'sms' ||
          uri.scheme == 'market' ||
          uri.scheme == 'itms-apps';
    } catch (e) {
      debugPrint('URL 파싱 오류: $e');
      return false;
    }
  }

  /// 특정 URL 스키마인지 확인
  static bool isScheme(String url, String scheme) {
    try {
      final uri = Uri.parse(url);
      return uri.scheme == scheme;
    } catch (e) {
      return false;
    }
  }

  /// 네트워크 연결 확인
  static Future<bool> hasNetworkConnection() async {
    try {
      // 실제 구현에서는 connectivity_plus 패키지를 사용
      // 여기서는 간단히 true 반환
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 네트워크 오류 다이얼로그 표시
  static Future<void> showNetworkErrorDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('네트워크 오류'),
        content: const Text('인터넷 연결을 확인해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  /// 로딩 다이얼로그 표시
  static void showLoadingDialog(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[const SizedBox(height: 16), Text(message)],
          ],
        ),
      ),
    );
  }

  /// 로딩 다이얼로그 닫기
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
