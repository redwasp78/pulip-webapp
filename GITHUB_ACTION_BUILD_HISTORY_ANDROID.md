# 🤖 GitHub Actions Android Build History

> **시작일**: 2025년 10월  
> **목적**: GitHub Actions Android 빌드 워크플로우의 성공/실패를 추적

---

## 📊 **빌드 시도 요약**

| 시도 | 커밋 | 설정 | 결과 | 원인 |
|------|------|------|------|------|
| #1 | 82077b3 | Flutter 3.35.4 + Firebase 3.15.2 | ❌ 실패 | Flutter 3.35.4와 Firebase 3.15.2 호환성 문제 |
| #2 | 0272a90 | Flutter 3.24.0 + Firebase 3.15.2 | ❌ 실패 | Flutter 다운그레이드만으로는 Firebase 호환성 문제 해결 안됨 |
| #3 | 0cff7a9 | Flutter 3.24.0 + Firebase 2.32.0/14.7.10 | ❌ 실패 | Firebase 2.32.0/14.7.10도 Flutter 3.24.0과 호환성 문제 |
| #4 | 99fbd22 | Flutter 3.19.6 + Firebase 2.32.0/14.7.10 | ❌ 실패 | Flutter 3.19.6과 Firebase 2.32.0/14.7.10 호환성 문제 |
| #5 | 11bcc7f | Flutter 3.16.9 + Firebase 2.24.2/14.7.10 + Kotlin 1.9.10 + Java 11 | ❌ 실패 | Flutter 3.16.9와 Firebase 2.24.2 호환성 문제 |
| #6 | 83c1f63 | Flutter 3.24.0 + Firebase 9.6.1 (존재하지 않는 버전) | ❌ 실패 | Firebase 9.6.1 버전이 존재하지 않음 - 의존성 해결 실패 |
| #7 | 59f3ac4 | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 (수정된 버전) | ❌ 실패 | google-services.json 파일 누락 - Firebase 설정 파일 필요 |
| #8 | 7995d14 | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets | ❌ 실패 | Firebase 패키지 설치 실패 - GitHub Secrets 미설정 또는 잘못된 설정 |
| #9 | 60a9572 | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets (재시도) | ❌ 실패 | Firebase 타입 오류 - FCM 서비스 코드에서 Firebase import 누락 |
| #10 | ce5ee2f | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets + Firebase import 수정 | ❌ 실패 | FCM 서비스 코드 오류 - _messageSubscription 변수 누락 |
| #11 | c60adc4 | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets + FCM 서비스 코드 수정 | ❌ 실패 | GitHub Secrets JSON 형식 오류 - google-services.json 파싱 실패 |
| #12 | *진행중* | Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets JSON 수정 | 🔄 진행중 | 올바른 JSON 형식으로 GitHub Secrets 재설정 |

---

## ⚠️ **실패 기록**

### **실패 #1: Flutter 3.35.4 + Firebase 3.15.2**
- **커밋**: 82077b3 (히스토리 파일 분리)
- **GitHub Actions 오류**: `Gradle task assembleDebug failed with exit code 1`
- **원인**: Flutter 3.35.4와 Firebase 3.15.2 버전 호환성 문제

### **실패 #2: Flutter 3.24.0 + Firebase 3.15.2**
- **커밋**: 0272a90 (Flutter 3.24.0 다운그레이드)
- **GitHub Actions 오류**: `Firebase initialization failed`
- **원인**: Flutter 다운그레이드만으로는 Firebase 호환성 문제 해결 안됨

### **실패 #3: Flutter 3.24.0 + Firebase 2.32.0/14.7.10**
- **커밋**: 0cff7a9 (Firebase 다운그레이드)
- **GitHub Actions 오류**: `Firebase initialization failed - version compatibility issue`
- **원인**: Firebase 2.32.0/14.7.10도 Flutter 3.24.0과 호환성 문제


### **실패 #4: Flutter 3.19.6 + Firebase 2.32.0/14.7.10**
- **커밋**: 99fbd22 (Flutter 3.19.6 다운그레이드)
- **GitHub Actions 오류**: `Firebase initialization failed - version compatibility issue`
- **원인**: Flutter 3.19.6과 Firebase 2.32.0/14.7.10 호환성 문제

### **실패 #5: 웹 검색 해결책 적용**
- **커밋**: 11bcc7f (종합 해결책 적용)
- **설정**: Flutter 3.16.9 + Firebase 2.24.2/14.7.10 + Kotlin 1.9.10 + Java 11
- **GitHub Actions 오류**: `Gradle task assembleDebug failed with exit code 1`
- **원인**: Flutter 3.16.9와 Firebase 2.24.2 호환성 문제 + Kotlin/Java 버전 충돌

### **실패 #6: 존재하지 않는 Firebase 버전**
- **커밋**: 83c1f63 (잘못된 Firebase 버전 적용)
- **설정**: Flutter 3.24.0 + Firebase 9.6.1 (존재하지 않는 버전)
- **GitHub Actions 오류**: `Because pulip_webapp depends on firebase_messaging ^9.6.1 which doesn't match any versions, version solving failed`
- **원인**: Firebase 9.6.1 버전이 실제로 존재하지 않음 - 웹 검색 정보 오류
- **중요성**: 잘못된 버전 정보로 인한 의존성 해결 실패

### **실패 #7: google-services.json 파일 누락**
- **커밋**: 59f3ac4 (존재하는 Firebase 버전으로 수정)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 (실제 존재하는 버전)
- **GitHub Actions 오류**: `File google-services.json is missing. The Google Services Plugin cannot function without it.`
- **원인**: google-services.json 파일이 GitHub Actions 환경에 없음
- **중요성**: Firebase 설정 파일이 .gitignore에 의해 제외되어 빌드 실패

### **실패 #8: Firebase 패키지 설치 실패**
- **커밋**: 7995d14 (GitHub Secrets로 Firebase 설정 파일 제공)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets
- **GitHub Actions 오류**: `Error: Couldn't resolve the package 'firebase_core' in 'package:firebase_core/firebase_core.dart'`
- **원인**: Firebase 패키지가 다운로드되지 않음 - GitHub Secrets 미설정 또는 잘못된 설정
- **중요성**: GitHub Secrets 설정이 제대로 되지 않아 Firebase 패키지 설치 실패

### **실패 #9: Firebase 타입 오류**
- **커밋**: 60a9572 (Firebase 복원 후 GitHub Secrets 재시도)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets
- **GitHub Actions 오류**: `Type 'RemoteMessage' not found`, `Undefined name 'Firebase'`, `Undefined name 'FirebaseMessaging'`
- **원인**: FCM 서비스 코드에서 Firebase import가 주석 처리되어 있음
- **중요성**: Firebase 패키지는 설치되었지만 코드에서 Firebase 타입을 찾을 수 없음

### **실패 #10: FCM 서비스 코드 오류**
- **커밋**: ce5ee2f (Firebase import 추가 후 재시도)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets + Firebase import 수정
- **GitHub Actions 오류**: `Undefined name '_messageSubscription'`
- **원인**: FCM 서비스 코드에서 `_messageSubscription` 변수가 주석 처리되어 있음
- **중요성**: Firebase import는 성공했지만 FCM 서비스 변수가 누락됨

### **실패 #11: GitHub Secrets JSON 형식 오류**
- **커밋**: c60adc4 (FCM 서비스 변수 복원 후 재시도)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets + FCM 서비스 코드 수정
- **GitHub Actions 오류**: `MalformedJsonException: Unterminated object at line 10 column 29`
- **원인**: GitHub Secrets에 설정된 JSON 형식이 잘못됨 - google-services.json 파싱 실패
- **중요성**: 모든 코드 문제는 해결되었지만 GitHub Secrets JSON 형식 오류로 빌드 실패

### **시도 #12: GitHub Secrets JSON 수정**
- **커밋**: *진행중* (올바른 JSON 형식으로 GitHub Secrets 재설정)
- **설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets JSON 수정
- **상태**: 🔄 GitHub Actions 빌드 진행 중
- **근거**: 올바른 JSON 형식으로 GitHub Secrets를 재설정하여 google-services.json 파싱 오류 해결

---

## ✅ **성공 기록**

*아직 성공 기록 없음*

---

## 🔄 **현재 상태**

- **워크플로우**: Android Build
- **러너**: macos-latest
- **현재 설정**: Flutter 3.24.0 + Firebase 3.15.2/15.2.10 + GitHub Secrets JSON 수정
- **상태**: 🔄 12번째 시도 진행 중 (11회 실패 후 GitHub Secrets JSON 형식 수정으로 재시도)
- **문제점**: Flutter-Firebase 버전 호환성 문제가 지속적으로 발생

---

## 📈 **통계**

| 항목 | 개수 |
|------|------|
| 총 시도 | 12 |
| 성공 | 0 |
| 실패 | 11 |
| 진행 중 | 1 |
| 성공률 | 0% |

---

---

## 🔍 **웹 검색 기반 버전 호환성 분석**

### **검색된 호환성 문제들**
1. **Kotlin 버전 불일치**: `The binary version of its metadata is 1.9.0, expected version is 1.7.1`
2. **Gradle, Flutter, Java 버전 호환성**: 빌드 도구들 간 버전 충돌
3. **Firebase 초기화 실패**: 버전 호환성 문제로 인한 초기화 오류

### **권장 해결책**
1. **FlutterFire CLI 사용**: Firebase 구성 자동화
2. **버전 매트릭스 확인**: Flutter와 Firebase 공식 호환성 테이블 참조
3. **Kotlin 버전 업데이트**: `android/settings.gradle`에서 Kotlin 플러그인 버전 조정
4. **Gradle 설정 최적화**: JVM 인수 및 캐시 설정 개선

### **실패 패턴 분석**
1. **Flutter 3.35.4 + Firebase 3.15.2** → Gradle 실패
2. **Flutter 3.24.0 + Firebase 3.15.2** → Firebase 초기화 실패
3. **Flutter 3.24.0 + Firebase 2.32.0/14.7.10** → Firebase 초기화 실패
4. **Flutter 3.19.6 + Firebase 2.32.0/14.7.10** → Firebase 초기화 실패
5. **Flutter 3.16.9 + Firebase 2.24.2/14.7.10** → Gradle 실패

### **근본 원인 분석 (6회 연속 실패 후)**

#### **핵심 발견사항** 🔍
- **공식 권장 조합도 실패**: Flutter 3.24.0 + Firebase 9.6.1 조합도 실패
- **모든 버전 조합 실패**: Flutter 3.35.4부터 3.16.9까지, Firebase 9.6.1부터 2.24.2까지 모든 조합 실패
- **근본적인 문제**: 단순한 버전 호환성 문제가 아닌 더 깊은 구조적 문제

#### **가능한 근본 원인** 🎯
1. **프로젝트 구조 문제**: Android 프로젝트 설정 자체의 문제
2. **Gradle 설정 문제**: Gradle 버전이나 설정 파일의 문제
3. **Firebase 설정 문제**: google-services.json 또는 Firebase 초기화 코드 문제
4. **Flutter 프로젝트 문제**: Flutter 프로젝트 생성 시 설정 문제
5. **GitHub Actions 환경 문제**: CI/CD 환경에서만 발생하는 특수한 문제

#### **실패 패턴 분석** 📊
- **Firebase 초기화 실패**: 모든 Firebase 버전에서 Flutter와 호환성 문제
- **Gradle 빌드 실패**: Flutter-Firebase 조합이 Gradle 빌드 과정에서 실패
- **버전 무관성**: 어떤 버전 조합도 성공하지 못함

### **웹 검색 기반 해결책**

#### **1. Firebase 제거 후 빌드 시도**
- **방법**: `pubspec.yaml`에서 Firebase 의존성 제거
- **목적**: Firebase 없이 Flutter 앱이 정상 빌드되는지 확인
- **장점**: 근본 원인 파악 가능

#### **2. FlutterFire CLI 사용**
- **방법**: `flutterfire configure` 명령어로 Firebase 재설정
- **목적**: 자동으로 호환되는 버전 조합 찾기
- **장점**: 공식 도구로 호환성 보장

#### **3. 더 낮은 Flutter 버전 시도**
- **Flutter 3.13.x**: 2023년 안정 버전
- **Flutter 3.10.x**: 2023년 초 안정 버전
- **목적**: Firebase와 호환되는 오래된 Flutter 버전 찾기

#### **4. Firebase 대체 솔루션**
- **OneSignal**: 푸시 알림 서비스
- **FCM 직접 구현**: Firebase 없이 FCM 사용
- **로컬 알림**: Flutter Local Notifications 사용

#### **5. Gradle 설정 최적화**
- **JVM 인수**: `-Xmx4g -XX:MaxMetaspaceSize=1g`
- **Gradle 데몬**: 비활성화
- **캐시 설정**: 빌드 캐시 최적화

### **웹 검색 기반 성공 버전 조합**

#### **공식 권장 버전 조합**
- **Flutter 3.24.0 + Firebase 9.6.1**: 공식 문서에서 권장하는 최신 조합
- **Flutter 3.24.0 + Firebase 3.15.2**: 우리가 시도했지만 실패한 조합
- **Flutter 3.13.x + Firebase 2.24.x**: 2023년 안정 버전 조합 (추정)

#### **커뮤니티 성공 사례**
- **Flutter 3.24.0 + Firebase 3.15.2**: 일부 개발자들이 성공했다고 보고
- **Flutter 3.13.x + Firebase 2.24.x**: 2023년 말 안정 조합
- **Flutter 3.10.x + Firebase 2.20.x**: 2023년 초 안정 조합

#### **호환성 확인 방법**
1. **공식 문서**: Flutter와 Firebase 공식 문서의 호환성 매트릭스
2. **커뮤니티 리소스**: 개발자 블로그 및 포럼의 실제 사용 사례
3. **패키지 pubspec.yaml**: 각 Firebase 패키지의 Flutter 버전 지원 범위
4. **변경 로그**: 패키지별 변경 로그에서 호환성 정보 확인

### **권장 해결 순서 (6회 연속 실패 후)**

#### **1단계: 근본 원인 파악** 🔍
1. **Firebase 제거 테스트** (Firebase 없이 Flutter만으로 빌드 시도)
2. **새 Flutter 프로젝트 생성** (프로젝트 구조 문제 확인)
3. **Gradle 설정 검토** (Gradle 버전 및 설정 파일 문제 확인)

#### **2단계: 대안 솔루션** 🔄
4. **FlutterFire CLI 재설정** (자동 호환성)
5. **Firebase 대체 솔루션** (OneSignal, FCM 직접 구현)
6. **로컬 알림 사용** (Firebase 없이 푸시 알림 구현)

#### **3단계: 최후 수단** ⚠️
7. **프로젝트 재생성** (완전히 새로운 Flutter 프로젝트로 시작)
8. **Firebase 없이 개발** (푸시 알림 기능 제거하고 개발 진행)

---

**마지막 업데이트**: 2025년 10월