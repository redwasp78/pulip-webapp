# 🔑 APNs 인증서 설정 가이드

## 🎯 **문제 진단**
Firebase Console에서 iOS 앱에 **APNs 인증서**가 등록되지 않아서 FCM이 푸시 알림을 보낼 수 없는 상황입니다.

## 📋 **해결 단계**

### **1단계: Apple Developer Console에서 APNs 인증서 생성**

#### **1.1 Apple Developer Portal 접속**
1. [Apple Developer Portal](https://developer.apple.com/account) 접속
2. Apple ID로 로그인
3. **"Certificates, Identifiers & Profiles"** 클릭

#### **1.2 App ID 확인/생성**
1. **"Identifiers"** → **"App IDs"** 클릭
2. **"+"** 클릭하여 새 App ID 생성 (또는 기존 것 확인)
3. **Bundle ID**: `kr.pe.kk.pulipWebapp`
4. **Capabilities**에서 **"Push Notifications"** 체크
5. **"Continue"** → **"Register"**

#### **1.3 CSR 파일 생성**
1. **Mac에서 Keychain Access** 실행
2. **"Keychain Access"** → **"Certificate Assistant"** → **"Request a Certificate From a Certificate Authority"**
3. **정보 입력**:
   - **User Email Address**: Apple Developer 계정 이메일
   - **Common Name**: 임의의 이름 (예: "Pulip WebApp CSR")
   - **CA Email Address**: 비워두기
   - **Request is**: "Saved to disk" 선택
4. **"Continue"** → **"Save"** (CSR 파일 저장)

#### **1.4 APNs 인증서 생성**
1. **Apple Developer Portal**에서 **"Certificates"** → **"+"** 클릭
2. **"Apple Push Notification service SSL (Sandbox & Production)"** 선택
3. **"Continue"**
4. **App ID**: `kr.pe.kk.pulipWebapp` 선택
5. **"Continue"**
6. **CSR 파일 업로드** (1.3에서 생성한 파일)
7. **"Continue"** → **"Download"** (인증서 다운로드)

#### **1.5 인증서를 .p12 파일로 변환**
1. **다운로드한 .cer 파일 더블클릭** (Keychain에 추가됨)
2. **Keychain Access**에서 **"My Certificates"** 확인
3. **인증서 우클릭** → **"Export"**
4. **파일 형식**: "Personal Information Exchange (.p12)" 선택
5. **비밀번호 설정** (나중에 Firebase에서 사용)
6. **"Save"**

### **2단계: Firebase Console에 APNs 인증서 등록**

#### **2.1 Firebase Console 접속**
1. [Firebase Console](https://console.firebase.google.com) 접속
2. **프로젝트 선택**: `webapp-190a2`

#### **2.2 Cloud Messaging 설정**
1. **"Project Settings"** (⚙️ 아이콘) 클릭
2. **"Cloud Messaging"** 탭 클릭
3. **"iOS app configuration"** 섹션 찾기

#### **2.3 APNs 인증서 업로드**
1. **"Upload Certificate"** 버튼 클릭
2. **1.5에서 생성한 .p12 파일 선택**
3. **비밀번호 입력** (1.5에서 설정한 비밀번호)
4. **"Upload"**

### **3단계: 앱에서 테스트**

#### **3.1 앱 재실행**
```bash
flutter run -d "iPhone 16 Pro"
```

#### **3.2 알림 권한 확인**
- 앱 실행 시 알림 권한 요청 팝업이 나타나야 함
- **"Allow"** 선택

#### **3.3 FCM 토큰 확인**
- 콘솔에서 FCM 토큰 출력 확인
- 토큰이 정상적으로 생성되면 성공

### **4단계: 푸시 알림 테스트**

#### **4.1 Firebase Console에서 테스트 메시지 전송**
1. **Firebase Console** → **"Cloud Messaging"**
2. **"Send your first message"** 클릭
3. **메시지 내용 입력**
4. **"Target"** → **"Single device"** 선택
5. **FCM 토큰 입력**
6. **"Review"** → **"Publish"**

## 🔍 **문제 해결**

### **일반적인 문제들:**

#### **1. "Invalid APNs certificate" 오류**
- **원인**: 잘못된 인증서 또는 비밀번호
- **해결**: 인증서 재생성 및 올바른 비밀번호 입력

#### **2. "App ID not found" 오류**
- **원인**: Bundle ID가 Apple Developer에 등록되지 않음
- **해결**: App ID 등록 및 Push Notifications 활성화

#### **3. "Certificate expired" 오류**
- **원인**: APNs 인증서 만료 (1년)
- **해결**: 새 인증서 생성 및 업로드

## 📱 **현재 앱 상태**

### **Firebase 초기화:**
- ✅ GoogleService-Info.plist 파일 존재
- ✅ Firebase 의존성 추가됨
- ❌ APNs 인증서 미등록 (FCM 작동 불가)

### **알림 권한:**
- ❌ Firebase 초기화 실패로 인한 권한 요청 불가
- ❌ FCM 토큰 생성 불가

## 🎯 **다음 단계**

1. **Apple Developer 계정** 필요 ($99/년)
2. **APNs 인증서 생성** 및 **Firebase 업로드**
3. **앱 재실행** 및 **알림 권한 확인**
4. **푸시 알림 테스트**

---
**결론**: APNs 인증서가 Firebase에 등록되지 않아서 FCM이 작동하지 않습니다. Apple Developer 계정이 필요하며, 인증서 생성 후 Firebase에 업로드해야 합니다.





