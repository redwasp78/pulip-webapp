# 🚀 앱 스토어 배포 가이드

## 📋 배포 전 체크리스트

### ✅ 필수 준비사항
- [ ] Google Play Console 계정 생성
- [ ] Apple Developer Program 가입
- [ ] 앱 서명 키 생성 (Android)
- [ ] App Store Connect API 키 생성 (iOS)
- [ ] Firebase 프로젝트 설정 완료
- [ ] 앱 아이콘 및 스크린샷 준비

## 🤖 Google Play Store 배포

### 1. Google Play Console 설정
1. [Google Play Console](https://play.google.com/console) 접속
2. 새 앱 생성
3. 앱 정보 입력:
   - 앱 이름: Pulip WebApp
   - 패키지명: kr.pe.kk.pulip_webapp
   - 카테고리: 비즈니스

### 2. 서비스 계정 설정
1. Google Cloud Console에서 서비스 계정 생성
2. Google Play Console에서 API 액세스 권한 부여
3. JSON 키 파일을 GitHub Secrets에 추가:
   ```
   GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
   ```

### 3. 자동 배포 실행
```bash
# GitHub Actions에서 수동 실행
# Actions > Deploy to App Stores > Run workflow
# Platform: android
# Track: internal
```

### 4. 수동 배포 (선택사항)
```bash
# 로컬에서 Fastlane 실행
cd android
fastlane deploy_internal
```

## 🍎 App Store 배포

### 1. App Store Connect 설정
1. [App Store Connect](https://appstoreconnect.apple.com) 접속
2. 새 앱 생성
3. 앱 정보 입력:
   - 앱 이름: Pulip WebApp
   - 번들 ID: kr.pe.kk.pulipWebapp
   - 카테고리: 비즈니스

### 2. API 키 설정
1. App Store Connect에서 API 키 생성
2. GitHub Secrets에 추가:
   ```
   APP_STORE_CONNECT_API_KEY
   ```

### 3. 자동 배포 실행
```bash
# GitHub Actions에서 수동 실행
# Actions > Deploy to App Stores > Run workflow
# Platform: ios
# Track: internal
```

### 4. 수동 배포 (선택사항)
```bash
# 로컬에서 Fastlane 실행
cd ios
fastlane deploy
```

## 📱 앱 스토어 메타데이터

### Google Play Store
- **앱 이름**: Pulip WebApp
- **짧은 설명**: 웹과 앱의 완벽한 결합, Pulip WebApp으로 편리한 모바일 경험을 시작하세요!
- **카테고리**: 비즈니스
- **콘텐츠 등급**: 모든 연령
- **키워드**: pulip, webapp, hybrid, mobile, webview, business

### App Store
- **앱 이름**: Pulip WebApp
- **부제목**: 웹과 앱의 완벽한 결합
- **카테고리**: 비즈니스
- **콘텐츠 등급**: 4+
- **키워드**: pulip, webapp, hybrid, mobile, webview, business

## 🔐 보안 설정

### Android 서명
```bash
# 키스토어 생성
keytool -genkey -v -keystore pulip-webapp-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias pulip-webapp

# 키스토어 정보를 GitHub Secrets에 추가
ANDROID_KEYSTORE_BASE64
ANDROID_KEYSTORE_PASSWORD
ANDROID_KEY_ALIAS
ANDROID_KEY_PASSWORD
```

### iOS 서명
- Xcode에서 자동 서명 설정
- Apple Developer 계정에서 인증서 생성
- 프로비저닝 프로파일 설정

## 📊 배포 모니터링

### Google Play Console
- 앱 상태 모니터링
- 크래시 리포트 확인
- 사용자 피드백 검토

### App Store Connect
- TestFlight 베타 테스트
- 앱 리뷰 상태 확인
- 사용자 피드백 검토

## 🚨 문제 해결

### 일반적인 문제들
1. **빌드 실패**: 의존성 버전 확인
2. **서명 오류**: 키스토어 및 인증서 확인
3. **업로드 실패**: 네트워크 연결 및 권한 확인

### 지원
- GitHub Issues: 버그 리포트
- 이메일: support@pulip.com
- 문서: README.md 참조

## 📈 배포 후 작업

### 1. 모니터링 설정
- Firebase Analytics 설정
- 크래시 리포팅 활성화
- 성능 모니터링 설정

### 2. 마케팅
- 앱 스토어 최적화 (ASO)
- 소셜 미디어 홍보
- 사용자 피드백 수집

### 3. 업데이트 계획
- 정기적인 기능 업데이트
- 보안 패치 적용
- 사용자 요청 기능 추가

---

**성공적인 배포를 위해 각 단계를 꼼꼼히 확인하세요!** 🎉





