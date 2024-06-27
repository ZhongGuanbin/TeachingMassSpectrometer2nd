import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:teaching_mass_spectrometer_2nd/frame_entrypoint.dart';
import 'package:teaching_mass_spectrometer_2nd/screens/home.dart';
import 'package:teaching_mass_spectrometer_2nd/screens/settings.dart';

/// 路由管理器
/// TODO: 需要将软件启动页'/'变更为登陆界面，登陆成功后进行跳转,或者在TMSFE软件启动前添加一个启动软件，即main函数启动的是登录软件，登陆成功后启动TMSFE软件
/// TODO: 这样TMSFE就能在内部用go_router维护自身的路由，登录成功的时候销毁登陆程序，启动TMSFE软件，登出的时候销毁TMSFE软件，启动登陆程序
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