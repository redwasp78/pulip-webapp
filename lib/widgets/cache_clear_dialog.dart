import 'package:flutter/material.dart';

/// 캐시 초기화 확인 다이얼로그
///
/// 사용자에게 캐시 초기화에 대한 확인을 요청합니다.
class CacheClearDialog extends StatefulWidget {
  const CacheClearDialog({super.key});

  @override
  State<CacheClearDialog> createState() => _CacheClearDialogState();
}

class _CacheClearDialogState extends State<CacheClearDialog> {
  bool _isClearing = false;

  /// 캐시 초기화 실행
  Future<void> _clearCache() async {
    setState(() {
      _isClearing = true;
    });

    try {
      // 실제 캐시 초기화 로직 구현
      // WebView 캐시, SharedPreferences 등
      await Future.delayed(const Duration(seconds: 2)); // 시뮬레이션

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('캐시가 성공적으로 초기화되었습니다.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('캐시 초기화 중 오류가 발생했습니다: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isClearing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('캐시 초기화'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning, color: Colors.orange, size: 48),
          const SizedBox(height: 16),
          const Text(
            '저장된 웹 데이터를 모두 삭제하시겠습니까?\n\n'
            '이 작업은 되돌릴 수 없으며, 다음에 앱을 사용할 때 일부 데이터가 다시 로드될 수 있습니다.',
            textAlign: TextAlign.center,
          ),
          if (_isClearing) ...[
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 8),
            const Text('캐시를 초기화하는 중...', style: TextStyle(fontSize: 12)),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isClearing ? null : () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: _isClearing ? null : _clearCache,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('초기화'),
        ),
      ],
    );
  }
}





