import 'package:flutter/material.dart';

/// WebView 하단 네비게이션 바
///
/// 뒤로가기, 앞으로가기, 홈, 새로고침 버튼을 제공합니다.
class WebViewBottomBar extends StatelessWidget {
  final bool canGoBack;
  final bool canGoForward;
  final VoidCallback onBack;
  final VoidCallback onForward;
  final VoidCallback onHome;
  final VoidCallback onRefresh;

  const WebViewBottomBar({
    super.key,
    required this.canGoBack,
    required this.canGoForward,
    required this.onBack,
    required this.onForward,
    required this.onHome,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 뒤로가기 버튼
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: canGoBack
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.grey,
            ),
            onPressed: canGoBack ? onBack : null,
            tooltip: '뒤로가기',
          ),

          // 앞으로가기 버튼
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: canGoForward
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.grey,
            ),
            onPressed: canGoForward ? onForward : null,
            tooltip: '앞으로가기',
          ),

          // 홈 버튼
          IconButton(
            icon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onHome,
            tooltip: '홈',
          ),

          // 새로고침 버튼
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: onRefresh,
            tooltip: '새로고침',
          ),
        ],
      ),
    );
  }
}

