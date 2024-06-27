import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_mass_spectrometer_2nd/frame_entrypoint.dart';
import 'package:teaching_mass_spectrometer_2nd/screens/home.dart';
import 'package:teaching_mass_spectrometer_2nd/screens/settings.dart';

/// 路由管理器
/// TODO: 需要将软件启动页'/'变更为登陆界面，登陆成功后进行跳转
/// TODO: 需要添加日志记录功能
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return FrameEntrypoint(
          shellContext: shellNavigatorKey.currentContext,
          child: child,
        );
      },
      routes: [
        /// Home
        GoRoute(path: '/', builder: (context, state) => const HomePage()),

        /// Settings
        GoRoute(
            path: '/settings', builder: (context, state) => const Settings()),

        /// 通过级联符号...加载配置文件中的路由
      ],
    ),
  ],
);