# 🔧 빌드 히스토리 및 실패 경험 기록

## 📱 **Android Build 워크플로우**

### ⚠️ **Android 빌드 실패한 설정들**

### Flutter 3.35.4 + Firebase 4.2.0
- **날짜**: 2024년 (여러 번 시도)
- **문제점**: 
  - GitHub Actions에서 빌드 실패
  - Firebase 4.2.0과 Flutter 3.35.4 호환성 문제
  - APK 생성 실패
- **오류**: Gradle task assembleDebug failed with exit code 1
- **해결책**: Flutter 3.24.0으로 되돌림

### Java 11 + Flutter 3.24.0
- **문제점**: Java 11이 Flutter 3.24.0과 호환성 문제
- **해결책**: Java 8로 되돌림

### Flutter 3.19.6 + 단순화된 워크플로우
- **날짜**: 2024년 12월
- **문제점**: 
  - GitHub Actions에서 여전히 빌드 실패
  - 단순화된 워크플로우로도 해결되지 않음
  - Flutter 3.19.6 다운그레이드도 실패
- **오류**: 구체적인 오류 메시지 확인 필요
- **시도한 해결책**: 
  - Flutter 3.24.0 → 3.19.6 다운그레이드
  - 워크플로우 단순화 (Gradle 설정 제거)
  - 복잡한 APK 검사 로직 제거
  - 타임아웃 및 verbose 로깅 제거

### Flutter 3.16.9 + Firebase 2.32.0/14.7.10
- **날짜**: 2024년 12월
- **문제점**: 
  - 가장 오래된 안정 버전으로도 GitHub Actions 빌드 실패
  - 로컬에서는 성공하지만 GitHub Actions에서만 실패
  - 환경 차이(Ubuntu vs macOS)가 주요 원인으로 추정
- **오류**: 환경 차이로 인한 빌드 실패
- **시도한 해결책**: 
  - Flutter 3.19.6 → 3.16.9 다운그레이드
  - Firebase core: 3.15.2 → 2.32.0 다운그레이드
  - Firebase messaging: 15.2.10 → 14.7.10 다운그레이드
  - 로컬 빌드 테스트 성공 (21.8초)
- **결론**: 버전 문제가 아닌 환경 차이 문제로 판단

### ✅ **Android 빌드 성공하는 안정 설정**

### 현재 Android 빌드 안정 설정
- **러너**: macos-latest (Ubuntu에서 실패하여 변경)
- **Flutter**: 3.35.4 (로컬과 동일)
- **Firebase Core**: 3.15.2
- **Firebase Messaging**: 15.2.10
- **Java**: 8
- **Kotlin JVM Target**: 1.8

### Android 빌드 테스트 결과
- ✅ 로컬 빌드 성공 (macOS)
- ✅ Android APK 생성 성공
- ✅ Firebase 기능 정상 작동
- 🔄 GitHub Actions 테스트 중 (macOS 러너)

## 🍎 **iOS Build 워크플로우**

### ✅ **iOS 빌드 성공하는 안정 설정**
- **러너**: macos-latest (원래부터)
- **Flutter**: 3.24.0 (안정적)
- **Firebase Core**: 3.15.2
- **Firebase Messaging**: 15.2.10
- **빌드 결과**: .app 번들 + .ipa 파일 생성

### iOS 빌드 테스트 결과
- ✅ GitHub Actions 빌드 성공
- ✅ iOS .app 번들 생성 성공
- ✅ iOS .ipa 파일 생성 성공 (Release 빌드 시)
- ✅ Firebase 기능 정상 작동

## 🚫 **시도하지 말아야 할 조합**

### Android 빌드
1. **Flutter 3.35.4 + Firebase 4.2.0** - 호환성 문제
2. **Flutter 3.24.0 + Java 11** - 버전 불일치
3. **Firebase 16.0.3 + Flutter 3.24.0** - 버전 불일치
4. **Flutter 3.19.6 + 단순화된 워크플로우** - 여전히 실패
5. **Flutter 3.16.9 + Firebase 2.32.0/14.7.10** - 환경 차이로 실패
6. **Ubuntu 러너** - 환경 차이로 인한 빌드 실패
7. **복잡한 Gradle 설정** - 오히려 문제 야기
8. **타임아웃 및 verbose 로깅** - 빌드 과정 방해

### iOS 빌드
- **현재까지 실패 없음** - macOS 러너에서 안정적

## 📋 **업그레이드 가이드**

새로운 Flutter 버전을 시도할 때:
1. 로컬에서 먼저 테스트
2. Firebase 패키지 호환성 확인
3. Java 버전 호환성 확인
4. GitHub Actions에서 테스트
5. 실패 시 즉시 이전 안정 버전으로 롤백

## 🔄 **롤백 절차**

빌드 실패 시:
1. Flutter 버전을 3.24.0으로 되돌림
2. Firebase 패키지를 3.15.2/15.2.10으로 되돌림
3. Java 버전을 8로 되돌림
4. 로컬에서 빌드 테스트
5. GitHub에 푸시

---
**마지막 업데이트**: 2024년 12월
**안정 버전**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10
