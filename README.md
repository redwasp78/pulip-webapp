# Pulip WebApp 📱

Flutter로 개발된 하이브리드 모바일 앱으로, Pulip 웹사이트를 네이티브 앱 경험으로 제공합니다.

## 🚀 주요 기능

### 🌐 WebView 기반 메인 화면
- **URL**: https://www.pulip.com
- 로딩 인디케이터 및 진행률 표시
- 당겨서 새로고침(Pull to Refresh) 지원
- Android/iOS 뒤로가기 버튼 동작
- JavaScript ↔ Flutter 간 양방향 통신
- 외부 링크는 기본 브라우저로 자동 열기

### 🔔 푸시 알림 (Firebase FCM)
- Firebase Cloud Messaging 연동
- 백그라운드 및 포그라운드 알림 지원
- 알림 클릭 시 WebView가 해당 URL로 이동
- 알림 권한 관리

### 🎨 스플래시 화면
- 로고와 로딩 애니메이션
- 3초 후 자동으로 WebView로 전환
- 부드러운 페이드 애니메이션

### ⚙️ 설정 메뉴
- URL 캐시 초기화
- 푸시 알림 허용/차단 설정
- 다크모드 토글
- 앱 버전 정보 표시

### 🎯 추가 기능
- Material Design 3 적용
- 라이트/다크 모드 지원
- 네트워크 오류 처리
- 외부 링크 자동 감지 및 처리

## 🛠️ 기술 스택

- **프레임워크**: Flutter 3.16.0+
- **언어**: Dart 3.0+
- **상태 관리**: Provider
- **WebView**: webview_flutter
- **푸시 알림**: Firebase Cloud Messaging
- **HTTP**: http
- **로컬 저장소**: shared_preferences
- **URL 런칭**: url_launcher
- **애니메이션**: flutter_spinkit

## 📋 사전 요구사항

### 개발 환경
- Flutter SDK 3.16.0 이상
- Dart SDK 3.0 이상
- Android Studio 또는 VS Code
- Xcode (iOS 개발 시)
- CocoaPods (iOS 개발 시)

### 플랫폼별 요구사항
- **Android**: API 21 (Android 5.0) 이상
- **iOS**: iOS 11.0 이상

## 🚀 설치 및 실행

### 1. 저장소 클론
```bash
git clone https://github.com/your-username/pulip-webapp.git
cd pulip-webapp
```

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. Firebase 설정
1. [Firebase Console](https://console.firebase.google.com/)에서 프로젝트 생성
2. Android/iOS 앱 등록
3. `google-services.json` (Android) 및 `GoogleService-Info.plist` (iOS) 파일을 각각 해당 디렉토리에 복사:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### 4. 앱 실행

#### Android
```bash
flutter run
```

#### iOS
```bash
flutter run
```

## 🔧 빌드

### Android APK 빌드
```bash
flutter build apk --release
```

### iOS IPA 빌드
```bash
flutter build ios --release --no-codesign
```

## 🚀 자동 배포

### GitHub Actions
이 프로젝트는 GitHub Actions를 사용하여 자동 빌드 및 배포를 지원합니다.

#### 워크플로우 트리거
- `main` 브랜치에 푸시 시: 자동 빌드 및 배포
- `develop` 브랜치에 푸시 시: 자동 빌드
- Pull Request 시: 코드 분석 및 테스트

#### 빌드 아티팩트
- Android APK: `build/app/outputs/flutter-apk/app-release.apk`
- iOS IPA: `build/ios/iphoneos/*.ipa`

### Fastlane (선택사항)
Fastlane을 사용한 자동 배포를 위한 설정이 포함되어 있습니다.

#### Android (Play Store)
```bash
fastlane android deploy
```

#### iOS (TestFlight)
```bash
fastlane ios deploy
```

## 📁 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── screens/
│   ├── splash_screen.dart   # 스플래시 화면
│   ├── webview_screen.dart  # WebView 메인 화면
│   └── settings_screen.dart # 설정 화면
├── services/
│   └── fcm_service.dart     # Firebase FCM 서비스
├── utils/
│   ├── app_state.dart       # 앱 상태 관리
│   └── navigation.dart      # 네비게이션 유틸리티
└── widgets/
    ├── webview_app_bar.dart    # WebView 상단 바
    ├── webview_bottom_bar.dart # WebView 하단 바
    └── cache_clear_dialog.dart # 캐시 초기화 다이얼로그
```

## 🔧 설정

### Android 설정
- `android/app/src/main/AndroidManifest.xml`: 권한 및 메타데이터 설정
- `android/app/src/main/res/xml/network_security_config.xml`: 네트워크 보안 설정

### iOS 설정
- `ios/Runner/Info.plist`: 권한 및 네트워크 보안 설정

## 🎨 커스터마이징

### 앱 이름 변경
1. `pubspec.yaml`에서 `name` 필드 수정
2. `android/app/src/main/AndroidManifest.xml`에서 `android:label` 수정
3. `ios/Runner/Info.plist`에서 `CFBundleDisplayName` 수정

### WebView URL 변경
`lib/screens/webview_screen.dart`에서 `_currentUrl` 변수 수정:
```dart
String _currentUrl = 'https://your-website.com';
```

### 테마 커스터마이징
`lib/main.dart`에서 `ThemeData` 설정 수정:
```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.yourColor,
    brightness: Brightness.light,
  ),
),
```

## 🐛 문제 해결

### 일반적인 문제

#### Firebase 설정 오류
- `google-services.json` 및 `GoogleService-Info.plist` 파일이 올바른 위치에 있는지 확인
- Firebase 프로젝트 설정에서 패키지명이 일치하는지 확인

#### WebView 로딩 오류
- 네트워크 연결 상태 확인
- `network_security_config.xml`에서 도메인 설정 확인

#### 빌드 오류
- Flutter 및 Dart SDK 버전 확인
- `flutter clean && flutter pub get` 실행

### 디버깅
```bash
flutter logs
```

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다.

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 지원

문제가 발생하거나 질문이 있으시면 이슈를 생성해 주세요.

---

**개발팀**: Pulip Team  
**이메일**: support@pulip.com  
**웹사이트**: https://www.pulip.com