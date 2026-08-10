import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/themes/my_theme.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyTheme.myTheme.colorScheme.primary,
            MyTheme.myTheme.colorScheme.secondary,
            MyTheme.myTheme.colorScheme.tertiary,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: MyTheme.myTheme.colorScheme.secondary.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "TRENDING NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "FlutterNews",
              style: MyTheme.myTheme.textTheme.labelLarge,
            ),
            const SizedBox(height: 6),
            Text(
              "Get the go-to platform for all your news needs — global affairs, tech, sports, entertainment & more. Fresh updates tailored to your interests.",
              style: MyTheme.myTheme.textTheme.labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 700))
        .slideY(
          begin: -0.06,
          end: 0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
        );
  }
}