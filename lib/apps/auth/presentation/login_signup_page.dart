import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';

class LoginSignupPage extends ConsumerStatefulWidget {
  const LoginSignupPage({super.key});

  @override
  ConsumerState<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends ConsumerState<LoginSignupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final phoneNumber = _phoneController.text.trim();
      ref.read(authControllerProvider.notifier).verifyPhoneNumber(
            phoneNumber: phoneNumber,
            onCodeSent: (verificationId) {
              context.go('/auth-code');
            },
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Login'),
            Tab(text: 'Sign Up'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAuthForm(isLogin: true),
          _buildAuthForm(isLogin: false),
        ],
      ),
    );
  }

  Widget _buildAuthForm({required bool isLogin}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+1234567890',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (!value.startsWith('+')) {
                  return 'Phone number must start with +';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _handleSubmit,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(isLogin ? 'Login' : 'Sign Up'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
