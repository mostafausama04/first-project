import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../hive.dart';
import '../screens/get_started_screen.dart';
import '../screens/login_signup_screen.dart';
import '../screens/main_navigation_screen.dart';
import '../screens/contact_detail_screen.dart';
import '../screens/new_reminder_screen.dart';
import '../screens/new_contact_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginSignupScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
      routes: [
        // Using a transparent modal page route for GoRouter
        GoRoute(
          path: 'new_contact',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final hiveKey = extra?['hiveKey'];
            final editData = extra?['contact'];

            return CustomTransitionPage(
              key: state.pageKey,
              fullscreenDialog: true,
              opaque: false, // Allows the main screen to remain visible underneath as an overlay
              child: Scaffold(
                backgroundColor: Colors.black54, // Dim background overlay
                body: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      child: NewContactScreen(
                        hiveKey: hiveKey,
                        editData: editData,
                      ),
                    ),
                  ),
                ),
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0); // Slide up from bottom
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: 'contact/:id',
          builder: (context, state) {
            final idParam = state.pathParameters['id']!;
            dynamic hiveKey = int.tryParse(idParam) ?? idParam;
            
            final rawContact = HiveService.getContact(hiveKey) ?? {
              'name': 'Unknown Contact',
              'phone': '',
              'email': '',
              'category': '',
              'picture': 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?w=400',
            };
            
            final contact = rawContact.map((key, value) => MapEntry(key, value?.toString() ?? ''));
            
            return ContactDetailScreen(contact: contact);
          },
        ),
        GoRoute(
          path: 'reminder/new',
          builder: (context, state) => const NewReminderScreen(),
        ),
      ],
    ),
  ],
);