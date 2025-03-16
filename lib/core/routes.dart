import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../apps/auth/presentation/onboarding_page.dart';
import '../apps/auth/presentation/login_signup_page.dart';
import '../apps/auth/presentation/auth_code_page.dart';
import '../apps/home/home_page.dart';
import '../apps/chat/chat_screen.dart';
import '../apps/contacts/contacts_page.dart';
import '../apps/calendar/calendar_page.dart';
import '../apps/profile/profile_page.dart';
import '../core/widgets/custom_navbar.dart';

final router = GoRouter(
  initialLocation: '/chat',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const LoginSignupPage(),
    ),
    GoRoute(
      path: '/auth-code',
      builder: (context, state) => const AuthCodePage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),

    // 🔹 Navbar'ı koruyan ShellRoute (Sayfa yenilenmeden geçiş sağlar)
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: const CustomNavBar(), // Navbar hep burada kalacak
        );
      },
      routes: [
        GoRoute(
          path: "/chat",
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: "/contacts",
          builder: (context, state) => const ContactsPage(),
        ),
        GoRoute(
          path: "/calendar",
          builder: (context, state) => const CalendarPage(),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
