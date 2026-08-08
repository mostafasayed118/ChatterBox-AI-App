import 'package:chat_ai_app/features/auth/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('OnboardingScreen', () {
    testWidgets('renders title and subtitle', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('Your AI Assistant'), findsOneWidget);
      expect(
        find.textContaining('Using this app'),
        findsOneWidget,
      );
    });

    testWidgets('renders Continue button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders onboarding image', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
