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
        GoRoute(
          path: 'new_contact',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            if (extra != null) {
              return NewContactScreen(
                hiveKey: extra['hiveKey'],
                editData: extra['contact'],
              );
            }
            return const NewContactScreen();
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