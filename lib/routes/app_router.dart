import 'package:go_router/go_router.dart';
import '../models.dart';
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
      path: 'new_contact',
      builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;
      if (extra != null) {
      return NewContactScreen(
      editIndex: extra['index'],
      editData: extra['contact'],
      );
    }
    return const NewContactScreen();
          },
        ),
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
        GoRoute(
          path: 'new_contact',
          builder: (context, state) => const NewContactScreen(),
        ),
        GoRoute(
          path: 'contact/:id',
          builder: (context, state) {
            final contactId = state.pathParameters['id']!;
            final contact = contacts.firstWhere(
              (c) => c['id'] == contactId,
              orElse: () => contacts[0],
            );
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