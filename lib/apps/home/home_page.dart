import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              // Navigate to login
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Hediyele!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create gift
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
