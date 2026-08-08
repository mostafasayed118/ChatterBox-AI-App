import 'package:chat_ai_app/core/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeNotifier', () {
    test('initial state is light theme', () {
      final notifier = ThemeNotifier();
      expect(notifier.state, ThemeMode.light);
    });

    test('toggleTheme switches from light to dark', () {
      final notifier = ThemeNotifier();
      expect(notifier.state, ThemeMode.light);
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.dark);
    });

    test('toggleTheme switches from dark to light', () {
      final notifier = ThemeNotifier();
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.dark);
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.light);
    });

    test('multiple toggles cycle correctly', () {
      final notifier = ThemeNotifier();
      expect(notifier.state, ThemeMode.light);
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.dark);
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.light);
      notifier.toggleTheme();
      expect(notifier.state, ThemeMode.dark);
    });
  });
}
