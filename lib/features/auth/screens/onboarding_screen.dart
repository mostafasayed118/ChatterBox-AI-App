import 'package:chat_ai_app/core/utils/app_colors.dart';
import 'package:chat_ai_app/features/chat_gemini/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/common/commons.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  AppStrings.onboardingTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 23,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  AppStrings.onboardingSubTitle,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.whiteColor
                            : AppColors.greyLightColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Image.asset(
              AppAssets.onboarding,
              height: 300,
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: () {
                navigatePush(context: context, screen: const HomeScreen());
              },
              child: SizedBox(
                height: 50,
                width: 290,
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      AppStrings.continueButton,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward, color: AppColors.whiteColor),
                  ],
                ),
              ),
              style: Theme.of(context).elevatedButtonTheme.style,
            ),
          ],
        ),
      ),
    );
  }
}
