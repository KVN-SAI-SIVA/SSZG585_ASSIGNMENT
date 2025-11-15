import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
  final primary = Theme.of(context).colorScheme.primary;
  final secondary = Theme.of(context).colorScheme.secondary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            secondary.withAlpha((0.06 * 255).round()),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Soft decorative circles
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: primary.withAlpha((0.06 * 255).round()),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -80,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                color: primary.withAlpha((0.04 * 255).round()),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Foreground content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
