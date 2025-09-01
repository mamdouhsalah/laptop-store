part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AutLoginLLoadingState extends AuthState {}
final class AuthLoginSuccessState extends AuthState {
  final   Map<String, dynamic> data;

  AuthLoginSuccessState({required this.data});
  
}
final class AuthregisterSuccessState extends AuthState {
  final   Map<dynamic, dynamic> data;

  AuthregisterSuccessState({required this.data});

  }
