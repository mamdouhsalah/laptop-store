import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/core/widget/CustomTextField.dart';
import 'package:state_mangement/feature/authentication/cubit/auth_cubit.dart';
import 'package:state_mangement/feature/authentication/view/screen/login_screen.dart';
import 'package:state_mangement/core/widget/validator.dart';
import 'package:state_mangement/feature/home/view/screen/home_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final tokenController = TextEditingController();
  final nationalIdController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final genderController = TextEditingController();

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    final theme = context.watch<ThemeCubit>().state;

    addImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      selectedImage = File(pickedFile!.path);
      setState(() {});
    }

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Container(
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
              color: Colors.white.withOpacity(0.8),
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
                        "Create Account",
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Sign up to continue",
                        style: TextStyle(
                          color: theme.textColor.withOpacity(0.7),
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: () {
                          addImage();
                        },
                        child: Container(
                          height: 100.h,
                          width: 100.h,

                          decoration: BoxDecoration(
                            color: theme.cardcolor,

                            borderRadius: BorderRadius.circular(50.r),
                            image: selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: theme.buttonColor,
                            size: 35.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      customtextField(
                        controller: nameController,
                        keyboard: TextInputType.name,
                        hint: "Enter your full name",
                        label: "Full Name",
                        icon: Icons.person,
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) =>
                            MyValidators.displayNamevalidator(val),
                      ),
                      SizedBox(height: 16.h),

                      customtextField(
                        keyboard: TextInputType.emailAddress,
                        controller: emailController,
                        hint: "Enter your email",
                        label: "Email",
                        icon: Icons.email,
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) => MyValidators.emailValidator(val),
                      ),
                      SizedBox(height: 16.h),

                      customtextField(
                        keyboard: TextInputType.numberWithOptions(signed: true),
                        controller: phoneController,
                        hint: "Enter your mobile number",
                        label: "Mobile",
                        icon: Icons.phone,
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) => MyValidators.phoneValidator(val),
                      ),
                      SizedBox(height: 16.h),

                      customtextField(
                        keyboard: TextInputType.text,
                        controller: nationalIdController,
                        hint: "Enter national ID",
                        label: "National ID",
                        icon: Icons.badge,
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) =>
                            MyValidators.nationalIdValidator(val),
                      ),
                      SizedBox(height: 16.h),
                      customtextField(
                        keyboard: TextInputType.text,
                        controller: genderController,
                        hint: "Gender",
                        label: "Your gender",
                        icon: Icons.transgender,
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) =>
                            MyValidators.genderValidator(value: val),
                      ),
                      SizedBox(height: 16.h),
                      customtextField(
                        keyboard: TextInputType.text,
                        controller: passwordController,
                        hint: "Enter password",
                        label: "Password",
                        icon: Icons.lock,
                        obscureText: obscurePassword,
                        onToggleVisibility: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) => MyValidators.passwordValidator(val),
                      ),
                      SizedBox(height: 16.h),

                      customtextField(
                        keyboard: TextInputType.text,
                        controller: repeatPasswordController,
                        hint: "Repeat password",
                        label: "Repeat Password",
                        icon: Icons.lock,
                        obscureText: obscureRepeatPassword,
                        onToggleVisibility: () {
                          setState(() {
                            obscureRepeatPassword = !obscureRepeatPassword;
                          });
                        },
                        textColor: theme.textColor,
                        buttonColor: theme.buttonColor,
                        validator: (val) =>
                            MyValidators.repeatPasswordValidator(
                              value: val,
                              password: passwordController.text,
                            ),
                      ),
                      SizedBox(height: 24.h),

                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthregisterSuccessState) {
                              if (state.data['status'] == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(state.data['message']),
                                    ),
                                    backgroundColor: theme.buttonColor,
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              } else if (state.data['status'] == 'error') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(state.data['message']),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).registerCubit(
                                    name: nameController.text,
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    nationalId: nationalIdController.text
                                        .trim(),
                                    gender: genderController.text
                                        .trim()
                                        .toLowerCase(),
                                    password: passwordController.text.trim(),
                                    //image: selectedImage!.path??'',
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.buttonColor,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: theme.backgroundColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Already have an account? Login",
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
    );
  }
}
