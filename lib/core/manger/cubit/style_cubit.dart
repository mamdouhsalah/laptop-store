import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
    : super(
        ThemeState(
          cardcolor: Color(0xffffffff),
          backgroundColor: Colors.white,
          buttonColor: Colors.green,
          textColor: Colors.black,
        ),
      );

  void changeTheme({
    required Color background,
    required Color button,
    required Color text,
    required Color card,
  }) {
    emit(
      ThemeState(
        backgroundColor: background,
        buttonColor: button,
        textColor: text,
        cardcolor: card,
      ),
    );
  }

  void setDarkTheme() {
    emit(
      ThemeState(
        backgroundColor: Colors.black,
        cardcolor: Color(0xff1a1a1e),
        buttonColor: Color(0xffdfe31d),
        textColor: Colors.white,
      ),
    );
  }

  void setLightTheme() {
    emit(
      ThemeState(
        backgroundColor: Colors.white,
        cardcolor: Color(0xffffffff),

        buttonColor: Color(0xff48d861),
        textColor: Colors.black,
      ),
    );
  }
}
