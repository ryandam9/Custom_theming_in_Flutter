import 'package:custom_theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicationTheme extends StateNotifier<AppTheme> {
  ApplicationTheme({themeType = ThemeType.FlockGreen})
      : _themeType = themeType,
        _theme = AppTheme.fromType(themeType),
        super(
          AppTheme.fromType(AppTheme.defaultTheme),
        );

  ThemeType _themeType;
  AppTheme _theme;

  AppTheme get theme => _theme;

  /// Switch between Light & Dark themes
  void changeTheme() {
    _themeType = _themeType == ThemeType.FlockGreen
        ? ThemeType.FlockGreen_Dark
        : ThemeType.FlockGreen;

    _theme = AppTheme.fromType(_themeType);

    state = _theme;
  }
}

final themeProvider = StateNotifierProvider<ApplicationTheme, AppTheme>(
    (ref) => ApplicationTheme());

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final AppTheme appTheme = ref.watch(themeProvider);

        // Build a ThemeData object using the current theme
        final ThemeData theme = appTheme.themeData;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Custom Theme'),
            ),
            body: const Center(
              child: Home(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ref.read(themeProvider.notifier).changeTheme();
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AppTheme appTheme = ref.watch(themeProvider);

        return Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: appTheme.bg2,
              ),
              child: const Center(
                child: Text(
                  'Hello World',
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
