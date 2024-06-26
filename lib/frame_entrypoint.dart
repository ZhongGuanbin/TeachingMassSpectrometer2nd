import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teaching_mass_spectrometer_2nd/generated/l10n.dart';
import 'package:teaching_mass_spectrometer_2nd/routes/router.dart';
import 'package:teaching_mass_spectrometer_2nd/theme.dart';
import 'package:teaching_mass_spectrometer_2nd/widgets/window_buttons.dart';
import 'package:window_manager/window_manager.dart';

class FrameEntrypoint extends StatefulWidget {
  const FrameEntrypoint({
    super.key,
    required this.child,
    required this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<FrameEntrypoint> createState() => _FrameEntrypointState();
}

class _FrameEntrypointState extends State<FrameEntrypoint> with WindowListener {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');

  late final List<NavigationPaneItem> originalItems = [
    PaneItem(
      key: const ValueKey('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
    ),
    PaneItemSeparator(),
  ].map<NavigationPaneItem>((e) {
    PaneItem buildPaneItem(PaneItem item) {
      return PaneItem(
        key: item.key,
        icon: item.icon,
        title: item.title,
        body: item.body,
        onTap: () {
          final path = (item.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            context.go(path);
          }
          item.onTap?.call();
        },
      );
    }

    if (e is PaneItemExpander) {
      return PaneItemExpander(
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: e.body,
        items: e.items.map((item) {
          if (item is PaneItem) return buildPaneItem(item);
          return item;
        }).toList(),
      );
    }
    if (e is PaneItem) return buildPaneItem(e);
    return e;
  }).toList();

  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = originalItems
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = FluentLocalizations.of(context);

    final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);

    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }

    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        // leading: () {
        //   final enabled = widget.shellContext != null && router.canPop();
        //   final onPressed = enabled
        //       ? () {
        //           if (router.canPop()) {
        //             context.pop();
        //             setState(() {});
        //           }
        //         }
        //       : null;
        //   return NavigationPaneTheme(
        //     data: NavigationPaneTheme.of(context).merge(
        //       NavigationPaneThemeData(
        //         unselectedIconColor: ButtonState.resolveWith((states) {
        //           if (states.isDisabled) {
        //             return ButtonThemeData.buttonColor(context, states);
        //           }
        //           return ButtonThemeData.uncheckedInputColor(
        //             FluentTheme.of(context),
        //             states,
        //           ).basedOnLuminance();
        //         }),
        //       ),
        //     ),
        //     child: Builder(
        //       builder: (context) => PaneItem(
        //         icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
        //         title: Text(localizations.backButtonTooltip),
        //         body: const SizedBox.shrink(),
        //         enabled: enabled,
        //       ).build(
        //         context,
        //         false,
        //         onPressed,
        //         displayMode: PaneDisplayMode.compact,
        //       ),
        //     ),
        //   );
        // }(),
        title: () {
          if (kIsWeb) {
            return Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                TMSLocalizations.of(context).appTitle,
                style: FluentTheme.of(context).typography.title,
              ),
            );
          }
          return DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                TMSLocalizations.of(context).appTitle,
                style: FluentTheme.of(context).typography.title,
              ),
            ),
          );
        }(),
        // actions: Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Align(
        //       alignment: AlignmentDirectional.centerEnd,
        //       child: Padding(
        //         padding: const EdgeInsetsDirectional.only(end: 8.0),
        //         child: ToggleSwitch(
        //           content: const Text('Theme Mode'),
        //           checked: FluentTheme.of(context).brightness.isDark,
        //           onChanged: (v) {
        //             if (v) {
        //               appTheme.mode = ThemeMode.dark;
        //             } else {
        //               appTheme.mode = ThemeMode.light;
        //             }
        //           },
        //         ),
        //       ),
        //     ),
        //     if (!kIsWeb) const WindowButtons(),
        //   ],
        // ),
        actions: !kIsWeb ? const WindowButtons() : null,
      ),
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        header: SizedBox(
          height: kOneLineTileHeight,
          child: ShaderMask(
            shaderCallback: (rect) {
              final color = appTheme.color.defaultBrushFor(
                theme.brightness,
              );
              return LinearGradient(
                colors: [
                  color,
                  color,
                ],
              ).createShader(rect);
            },
            child: const FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 80.0,
              textColor: Colors.white,
              duration: Duration.zero,
            ),
          ),
        ),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: originalItems,
        footerItems: footerItems,
        size: const NavigationPaneSize(openWidth: 230),

        // autoSuggestBox: Builder(
        //   builder: (context) {
        //     return AutoSuggestBox(
        //       key: searchKey,
        //       focusNode: searchFocusNode,
        //       controller: searchController,
        //       unfocusedColor: Colors.transparent,
        //       // also need to include sub items from [PaneItemExpander] items
        //       items: <PaneItem>[
        //         ...originalItems
        //             .whereType<PaneItemExpander>()
        //             .expand<PaneItem>((item) {
        //           return [
        //             item,
        //             ...item.items.whereType<PaneItem>(),
        //           ];
        //         }),
        //         ...originalItems
        //             .where(
        //               (item) => item is PaneItem && item is! PaneItemExpander,
        //             )
        //             .cast<PaneItem>(),
        //       ].map((item) {
        //         assert(item.title is Text);
        //         final text = (item.title as Text).data!;
        //         return AutoSuggestBoxItem(
        //           label: text,
        //           value: text,
        //           onSelected: () {
        //             item.onTap?.call();
        //             searchController.clear();
        //             searchFocusNode.unfocus();
        //             final view = NavigationView.of(context);
        //             if (view.compactOverlayOpen) {
        //               view.compactOverlayOpen = false;
        //             } else if (view.minimalPaneOpen) {
        //               view.minimalPaneOpen = false;
        //             }
        //           },
        //         );
        //       }).toList(),
        //       trailingIcon: IgnorePointer(
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: const Icon(FluentIcons.search),
        //         ),
        //       ),
        //       placeholder: 'Search',
        //     );
        //   },
        // ),
        // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
      ),
      // onOpenSearch: searchFocusNode.requestFocus,
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
