import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/feature/authentication/cubit/auth_cubit.dart';
import 'package:state_mangement/core/widget/CustomTextField.dart';
import 'package:state_mangement/feature/authentication/view/screen/register_screen.dart';
import 'package:state_mangement/core/widget/validator.dart';
import 'package:state_mangement/feature/home/view/screen/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoginSuccessState) {
            final status = state.data['status'];
            final message = state.data['message'];

            if (status == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.green),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (status == 'error') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          }
        },
        child: Stack(
          children: [
            /// --- الفورم الأساسي
            Container(
              width: double.infinity.w,
              height: double.infinity.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/wallpaper.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Card(
                    color: Colors.white.withOpacity(0.7),
                    elevation: 8.sp,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                color: theme.textColor,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Login to your account",
                              style: TextStyle(
                                color: theme.textColor.withOpacity(0.7),
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 30.h),

                            /// Email
                            customtextField(
                              keyboard: TextInputType.emailAddress,
                              controller: emailController,
                              hint: "Enter your email",
                              label: "Email",
                              icon: Icons.email,
                              textColor: theme.textColor,
                              buttonColor: theme.buttonColor,
                              validator: (val) =>
                                  MyValidators.emailValidator(val),
                            ),
                            SizedBox(height: 16.h),

                            /// Password
                            customtextField(
                              keyboard: TextInputType.visiblePassword,
                              controller: passwordController,
                              hint: "Enter your password",
                              label: "Password",
                              icon: Icons.lock,
                              textColor: theme.textColor,
                              buttonColor: theme.buttonColor,
                              obscureText: obscurePassword,
                              onToggleVisibility: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              validator: (val) =>
                                  MyValidators.passwordValidator(val),
                            ),
                            SizedBox(height: 24.h),

                            /// Login Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.buttonColor,
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).loginCubit(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: theme.backgroundColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Don't have an account? Register",
                                style: TextStyle(color: theme.buttonColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /// --- Overlay اللودينج
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AutLoginLLoadingState) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.buttonColor,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
