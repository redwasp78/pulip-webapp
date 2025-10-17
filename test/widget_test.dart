// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_platform_interface/src/webview_platform.dart';

import 'package:pulip_webapp/main.dart';

class MockWebViewPlatform extends WebViewPlatform {
  @override
  WebViewPlatformController createPlatformController(
    WebViewPlatformControllerCreationParams params,
  ) {
    throw UnimplementedError();
  }
}

void main() {
  setUpAll(() {
    WebViewPlatform.instance = MockWebViewPlatform();
  });

  testWidgets('Pulip WebApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PulipWebApp());

    // Verify that the app starts with splash screen
    expect(find.text('Pulip WebApp'), findsOneWidget);
    expect(find.text('웹과 앱의 완벽한 결합'), findsOneWidget);
    
    // Wait for any pending timers to complete
    await tester.pumpAndSettle();
    
    // Clean up any remaining timers
    await tester.binding.delayed(Duration.zero);
  });
}
