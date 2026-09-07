import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:first_project/app_theme.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: const BoxDecoration(
                color: kAccentColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Let's Get Started",
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: () => context.go('/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkTextColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 16),
                    ),
                    child: const Text("JOIN NOW"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}