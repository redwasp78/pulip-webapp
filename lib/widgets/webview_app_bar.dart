import 'package:flutter/material.dart';

/// WebView 상단 앱바
///
/// URL 표시, 로딩 진행률, 새로고침, 설정 버튼을 포함합니다.
class WebViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String url;
  final bool isLoading;
  final int progress;
  final VoidCallback onRefresh;
  final VoidCallback onSettings;

  const WebViewAppBar({
    super.key,
    required this.url,
    required this.isLoading,
    required this.progress,
    required this.onRefresh,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text('Pulip WebApp'),
          if (isLoading)
            LinearProgressIndicator(
              value: progress / 100.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
      actions: [
        // 새로고침 버튼
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefresh,
          tooltip: '새로고침',
        ),

        // 설정 버튼
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettings,
          tooltip: '설정',
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            url,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);
}

