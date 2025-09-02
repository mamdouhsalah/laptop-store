import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/feature/authentication/model/auth_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthData authData = AuthData();
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  loginCubit({required String email, required String password}) async {
    emit(AutLoginLLoadingState());

    var data = await authData.loginData(email: email, password: password);

    emit(AuthLoginSuccessState(data: data));
  }

  registerCubit({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String nationalId,
    required String gender,
  }) async {
    emit(AutLoginLLoadingState());
    var data = await authData.registerData(
      email: email,
      password: password,
      name: name,
      phone: phone,
      //profileImage: image,
      nationalId: nationalId,
      gender: gender,
    );

    emit(AuthregisterSuccessState(data: data));
  }
}
