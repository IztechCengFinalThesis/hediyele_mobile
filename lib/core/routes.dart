import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../apps/auth/presentation/onboarding_page.dart';
import '../apps/auth/presentation/login_signup_page.dart';
import '../apps/auth/presentation/auth_code_page.dart';
import '../apps/home/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
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
  ],
);
