import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';
import 'dart:async';

class AuthCodePage extends ConsumerStatefulWidget {
  const AuthCodePage({super.key});

  @override
  ConsumerState<AuthCodePage> createState() => _AuthCodePageState();
}

class _AuthCodePageState extends ConsumerState<AuthCodePage> {
  bool _isLoading = false;
  Timer? _timer;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _checkEmailVerification() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authControllerProvider.notifier).checkEmailVerified();
      if (mounted) {
        context.go('/home');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not verified yet. Please check your inbox.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resendVerificationEmail() async {
    if (_remainingTime > 0) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(authControllerProvider.notifier).resendVerificationEmail();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification email sent. Please check your inbox.'),
          ),
        );
        _startTimer();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verify Your Email',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'We\'ve sent a verification link to your email address.\nPlease check your inbox and verify your email.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _checkEmailVerification,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : const Text('I\'ve Verified My Email'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed:
                      _isLoading || _remainingTime > 0
                          ? null
                          : _resendVerificationEmail,
                  child: Text(
                    _remainingTime > 0
                        ? 'Resend email in ${_remainingTime}s'
                        : 'Resend verification email',
                    style: TextStyle(
                      color:
                          _isLoading || _remainingTime > 0
                              ? Colors.grey
                              : Colors.blue[700],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text.rich(
                TextSpan(
                  text:
                      'By registering with an account, you agree to Hediyele\'s ',
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
