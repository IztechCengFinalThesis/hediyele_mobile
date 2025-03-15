import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';

class AuthCodePage extends ConsumerStatefulWidget {
  const AuthCodePage({super.key});

  @override
  ConsumerState<AuthCodePage> createState() => _AuthCodePageState();
}

class _AuthCodePageState extends ConsumerState<AuthCodePage> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final code = _codeController.text.trim();
      ref
          .read(authControllerProvider.notifier)
          .signInWithPhoneNumber(code)
          .then((_) {
        context.go('/home');
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the verification code sent to your phone',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                  hintText: '123456',
                  prefixIcon: Icon(Icons.lock),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  if (value.length != 6) {
                    return 'Code must be 6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _handleSubmit,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Verify'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
