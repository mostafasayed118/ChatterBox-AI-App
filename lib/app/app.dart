import 'package:chat_ai_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/theme_notifier.dart';
import '../core/utils/app_strings.dart';
import '../features/auth/screens/onboarding_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: themeMode,
      home: const OnboardingScreen(),
    );
  }
}
