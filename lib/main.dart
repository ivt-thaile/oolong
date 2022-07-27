import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: false,
      );
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setFullScreen(false);
      await windowManager.setAlwaysOnTop(false);
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        displayMode: PaneDisplayMode.auto,
        items: [
          PaneItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          PaneItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
      content: Center(
        child: Text('Hello!'),
      ),
    );
  }
}
