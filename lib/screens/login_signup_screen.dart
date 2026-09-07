import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:first_project/app_theme.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: kAccentColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back!",
                    style: Theme.of(context).textTheme.displayLarge),
                Text("Enter your details to proceed",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 48),
                const TextField(
                    decoration: InputDecoration(
                        labelText: 'Email', border: UnderlineInputBorder())),
                const SizedBox(height: 16),
                const TextField(
                    decoration: InputDecoration(
                        labelText: 'Username', border: UnderlineInputBorder())),
                const SizedBox(height: 16),
                const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', border: UnderlineInputBorder())),
                const SizedBox(height: 48),
                Center(
                  child: ElevatedButton(
                    onPressed: () => context.go('/home'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkTextColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48, vertical: 16),
                    ),
                    child: const Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}