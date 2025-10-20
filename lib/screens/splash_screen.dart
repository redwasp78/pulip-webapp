import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 스플래시 화면
///
/// 앱 시작 시 로고와 로딩 애니메이션을 표시합니다.
/// 3초 후 자동으로 WebView 화면으로 전환됩니다.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // 페이드 애니메이션 설정
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // 애니메이션 시작
    _animationController.forward();

    // 3초 후 WebView 화면으로 전환
    _navigateToWebView();
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  /// WebView 화면으로 전환
  void _navigateToWebView() {
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/webview');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고 이미지 (실제 프로젝트에서는 assets/images/logo.png 사용)
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(Icons.web, size: 60, color: Colors.blue),
              ),

              const SizedBox(height: 30),

              // 앱 이름
              const Text(
                'Pulip WebApp',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              // 부제목
              const Text(
                '웹과 앱의 완벽한 결합',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),

              const SizedBox(height: 50),

              // 로딩 인디케이터
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
