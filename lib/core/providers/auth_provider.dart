import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../apps/auth/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
      return AuthController(ref.watch(authServiceProvider));
    });

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  AuthController(this._authService) : super(const AsyncValue.data(null));

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      await _authService.checkEmailVerified();
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.createUserWithEmailAndPassword(email, password);
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      rethrow;
    }
  }

  Future<void> checkEmailVerified() async {
    state = const AsyncValue.loading();
    try {
      await _authService.checkEmailVerified();
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      rethrow;
    }
  }

  Future<void> resendVerificationEmail() async {
    state = const AsyncValue.loading();
    try {
      await _authService.resendVerificationEmail();
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      await _authService.sendPasswordResetEmail(email);
      state = const AsyncValue.data(null);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
      rethrow;
    }
  }

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onError: onError,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithPhoneNumber(smsCode);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
