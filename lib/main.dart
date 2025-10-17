import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:pulip_webapp/screens/splash_screen.dart';
import 'package:pulip_webapp/screens/webview_screen.dart';
import 'package:pulip_webapp/screens/settings_screen.dart';
// import 'package:pulip_webapp/services/fcm_service.dart';
import 'package:pulip_webapp/utils/app_state.dart';

/// Pulip WebApp 메인 진입점
///
/// 앱의 초기화, Firebase 설정, 라우팅을 담당합니다.
/// Material Design을 사용하여 라이트/다크 모드를 지원합니다.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화 (임시 주석 처리)
  // await Firebase.initializeApp();
  
  // FCM 서비스 초기화 (임시 주석 처리)
  // await FCMService.initialize();
  
  runApp(const PulipWebApp());
}

class PulipWebApp extends StatelessWidget {
  const PulipWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'Pulip WebApp',
            debugShowCheckedModeBanner: false,

            // 테마 설정 (라이트/다크 모드 지원)
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
              appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
            ),
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            // 라우팅 설정
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/webview': (context) => const WebViewScreen(),
              '/settings': (context) => const SettingsScreen(),
            },

            // 알림 클릭 시 라우팅 처리
            onGenerateRoute: (settings) {
              if (settings.name?.startsWith('/webview?') == true) {
                final uri = Uri.parse(settings.name!);
                final targetUrl = uri.queryParameters['url'];
                return MaterialPageRoute(
                  builder: (context) => WebViewScreen(initialUrl: targetUrl),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
