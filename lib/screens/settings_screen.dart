import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:pulip_webapp/utils/app_state.dart';
import 'package:pulip_webapp/widgets/cache_clear_dialog.dart';

/// 설정 화면
///
/// 앱의 다양한 설정 옵션을 제공합니다.
/// 다크모드, 알림 설정, 캐시 관리, 앱 정보 등을 포함합니다.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // PackageInfo? _packageInfo; // 임시 주석 처리

  @override
  void initState() {
    super.initState();
    // _loadPackageInfo(); // 임시 주석 처리
  }

  /// 패키지 정보 로드 (임시 주석 처리)
  // Future<void> _loadPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _packageInfo = info;
  //   });
  // }

  /// 캐시 초기화 다이얼로그 표시
  void _showCacheClearDialog() {
    showDialog(
      context: context,
      builder: (context) => const CacheClearDialog(),
    );
  }

  /// 앱 정보 다이얼로그 표시
  void _showAppInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('앱 정보'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('앱 이름: Pulip WebApp'),
            SizedBox(height: 8),
            Text('버전: 1.0.0'),
            SizedBox(height: 8),
            Text('빌드 번호: 1'),
            SizedBox(height: 8),
            Text('패키지명: kr.pe.kk.webapp'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 디스플레이 설정
              _buildSectionHeader('디스플레이'),
              _buildSwitchTile(
                title: '다크 모드',
                subtitle: '어두운 테마 사용',
                value: appState.isDarkMode,
                onChanged: (value) => appState.setDarkMode(value),
                icon: Icons.dark_mode,
              ),

              const SizedBox(height: 24),

              // 알림 설정
              _buildSectionHeader('알림'),
              _buildSwitchTile(
                title: '푸시 알림',
                subtitle: '앱 알림 수신 허용',
                value: appState.isNotificationEnabled,
                onChanged: (value) => appState.setNotification(value),
                icon: Icons.notifications,
              ),

              const SizedBox(height: 24),

              // 데이터 관리
              _buildSectionHeader('데이터 관리'),
              _buildListTile(
                title: '캐시 초기화',
                subtitle: '저장된 웹 데이터 삭제',
                icon: Icons.clear_all,
                onTap: _showCacheClearDialog,
              ),

              const SizedBox(height: 24),

              // 앱 정보
              _buildSectionHeader('앱 정보'),
              _buildListTile(
                title: '앱 정보',
                subtitle: '버전 및 빌드 정보',
                icon: Icons.info,
                onTap: _showAppInfoDialog,
              ),
              _buildListTile(
                title: '개발자 정보',
                subtitle: 'kr.pe.kk.webapp',
                icon: Icons.code,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('개발자: Pulip Team'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 버전 정보
              Center(
                child: Text(
                  '버전 1.0.0 (1)',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 섹션 헤더 위젯
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  /// 스위치 타일 위젯
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        secondary: Icon(icon),
      ),
    );
  }

  /// 리스트 타일 위젯
  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
