import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      // simulasi delay API
      await Future.delayed(const Duration(seconds: 1));

      // Basic validation
      if (email.isEmpty || password.isEmpty) {
        emit(AuthError('Email dan password harus diisi'));
        return;
      }

      // Check if admin (hardcoded untuk demo)
      bool isAdmin = email.toLowerCase() == 'admin@guitarestore.com';
      
      // anggap selalu sukses (nanti bisa ganti API beneran)
      emit(AuthAuthenticated(role: isAdmin ? 'admin' : 'user', email: email));
    } catch (e) {
      emit(AuthError('Login gagal: ${e.toString()}'));
    }
  }

  void logout() {
    emit(AuthUnauthenticated());
  }
}

/// STATES

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String role; // 'admin' or 'user'
  final String email;

  AuthAuthenticated({required this.role, required this.email});
  
  @override
  List<Object?> get props => [role, email];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
  
  @override
  List<Object?> get props => [message, DateTime.now().millisecondsSinceEpoch];
}
