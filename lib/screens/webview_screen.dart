import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pulip_webapp/widgets/webview_app_bar.dart';
import 'package:pulip_webapp/widgets/webview_bottom_bar.dart';

/// WebView 메인 화면
/// 
/// Pulip 웹사이트를 표시하는 메인 화면입니다.
/// 당겨서 새로고침, 뒤로가기, JavaScript 통신, 외부 링크 처리 기능을 제공합니다.
class WebViewScreen extends StatefulWidget {
  final String? initialUrl;
  
  const WebViewScreen({
    super.key,
    this.initialUrl,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  final bool _canGoBack = false;
  final bool _canGoForward = false;
  String _currentUrl = 'https://www.pulip.com';
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    
    // 초기 URL 설정
    if (widget.initialUrl != null) {
      _currentUrl = widget.initialUrl!;
    }
    
    _initializeWebView();
  }

  /// WebView 초기화
  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress;
              _isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _currentUrl = url;
            });
            
            // JavaScript 통신 설정
            _setupJavaScriptChannels();
          },
          onNavigationRequest: (NavigationRequest request) {
            // 외부 링크 처리
            if (_isExternalLink(request.url)) {
              _launchExternalUrl(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  /// JavaScript 채널 설정
  void _setupJavaScriptChannels() {
    // Flutter와 JavaScript 간 통신을 위한 채널
    _controller.addJavaScriptChannel(
      'FlutterApp',
      onMessageReceived: (JavaScriptMessage message) {
        _handleJavaScriptMessage(message.message);
      },
    );
    
    // JavaScript에서 Flutter 함수를 호출할 수 있도록 설정
    _controller.runJavaScript('''
      window.flutter = {
        postMessage: function(message) {
          FlutterApp.postMessage(message);
        }
      };
    ''');
  }

  /// JavaScript 메시지 처리
  void _handleJavaScriptMessage(String message) {
    try {
      // JSON 형태의 메시지 파싱
      final data = message;
      
      // 메시지 타입에 따른 처리
      if (data.contains('notification')) {
        // 알림 관련 메시지 처리
        _showNotification(data);
      } else if (data.contains('navigation')) {
        // 네비게이션 관련 메시지 처리
        _handleNavigation(data);
      }
    } catch (e) {
      debugPrint('JavaScript 메시지 처리 오류: $e');
    }
  }

  /// 외부 링크인지 확인
  bool _isExternalLink(String url) {
    final uri = Uri.parse(url);
    final currentHost = Uri.parse(_currentUrl).host;
    
    // 다른 도메인이거나 특정 프로토콜인 경우 외부 링크로 처리
    return uri.host != currentHost || 
           uri.scheme == 'tel' || 
           uri.scheme == 'mailto' ||
           uri.scheme == 'sms';
  }

  /// 외부 URL 실행
  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// 새로고침
  void _refresh() {
    _controller.reload();
  }

  /// 뒤로가기
  void _goBack() {
    if (_canGoBack) {
      _controller.goBack();
    }
  }

  /// 앞으로가기
  void _goForward() {
    if (_canGoForward) {
      _controller.goForward();
    }
  }

  /// 홈으로 이동
  void _goHome() {
    _controller.loadRequest(Uri.parse('https://www.pulip.com'));
  }

  /// 설정 화면으로 이동
  void _goToSettings() {
    Navigator.of(context).pushNamed('/settings');
  }

  /// 알림 표시
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('알림: $message'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 네비게이션 처리
  void _handleNavigation(String data) {
    // JavaScript에서 요청한 네비게이션 처리
    if (data.contains('goHome')) {
      _goHome();
    } else if (data.contains('goBack')) {
      _goBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WebViewAppBar(
        url: _currentUrl,
        isLoading: _isLoading,
        progress: _progress,
        onRefresh: _refresh,
        onSettings: _goToSettings,
      ),
      body: Stack(
        children: [
          // WebView
          RefreshIndicator(
            onRefresh: () async {
              _refresh();
            },
            child: WebViewWidget(controller: _controller),
          ),
          
          // 로딩 오버레이
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      '페이지를 불러오는 중...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: WebViewBottomBar(
        canGoBack: _canGoBack,
        canGoForward: _canGoForward,
        onBack: _goBack,
        onForward: _goForward,
        onHome: _goHome,
        onRefresh: _refresh,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
