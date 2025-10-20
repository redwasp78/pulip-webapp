#!/bin/bash

# iOS 빌드 스크립트
# Pulip WebApp iOS 배포용 빌드

set -e

echo "🍎 Pulip WebApp iOS 빌드 시작..."

# Flutter 정리 및 의존성 설치
echo "📦 Flutter 의존성 설치..."
flutter clean
flutter pub get

# iOS 의존성 설치
echo "📱 iOS 의존성 설치..."
cd ios
pod install
cd ..

# iOS 빌드
echo "🔨 iOS IPA 빌드..."
flutter build ipa --release

# 빌드 결과 확인
echo "✅ 빌드 완료!"
echo "📁 IPA 파일 위치: build/ios/ipa/"
ls -la build/ios/ipa/

# dist 폴더로 복사
echo "📋 배포용 폴더로 복사..."
mkdir -p dist/ios
cp build/ios/ipa/*.ipa dist/ios/

echo "🎉 iOS 빌드 완료!"
echo "📱 IPA 파일: dist/ios/"
ls -la dist/ios/

echo ""
echo "📋 다음 단계:"
echo "1. Apple Developer 계정 설정"
echo "2. Xcode에서 개발팀 선택"
echo "3. App Store Connect에서 앱 생성"
echo "4. Apple Transporter로 IPA 업로드"
echo ""
echo "📖 자세한 가이드: dist/iOS_DEPLOYMENT_GUIDE.md"