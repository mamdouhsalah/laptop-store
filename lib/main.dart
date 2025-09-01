import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/bloc/bloc_ob.dart';
import 'package:state_mangement/my_app.dart';

void main() {
  MyBlocObserver ob = MyBlocObserver();
  Bloc.observer = ob;

  runApp(const MyApp());
}
