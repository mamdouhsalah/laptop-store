import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement/feature/authentication/cubit/auth_cubit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/core/widget/validator.dart';
import 'dart:io';
import 'package:state_mangement/core/widget/CustomTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:state_mangement/feature/authentication/view/screen/login_screen.dart';

class Successregister extends StatefulWidget {
  const Successregister({super.key});

  @override
  State<Successregister> createState() => _SuccessregisterState();
}

class _SuccessregisterState extends State<Successregister> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nationalIdController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final genderController = TextEditingController();

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;
  File? selectedImage;

  final picker = ImagePicker();

  addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Container(
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

                    /// صورة البروفايل
                    GestureDetector(
                      onTap: addImage,
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
                        child: selectedImage == null
                            ? Icon(
                                Icons.camera_alt,
                                color: theme.buttonColor,
                                size: 35.sp,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// Full Name
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

                    /// Email
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

                    /// Phone
                    customtextField(
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      controller: phoneController,
                      hint: "Enter your mobile number",
                      label: "Mobile",
                      icon: Icons.phone,
                      textColor: theme.textColor,
                      buttonColor: theme.buttonColor,
                      validator: (val) => MyValidators.phoneValidator(val),
                    ),
                    SizedBox(height: 16.h),

                    /// National ID
                    customtextField(
                      keyboard: TextInputType.text,
                      controller: nationalIdController,
                      hint: "Enter national ID",
                      label: "National ID",
                      icon: Icons.badge,
                      textColor: theme.textColor,
                      buttonColor: theme.buttonColor,
                      validator: (val) => MyValidators.nationalIdValidator(val),
                    ),
                    SizedBox(height: 16.h),

                    /// Gender
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

                    /// Password
                    customtextField(
                      keyboard: TextInputType.visiblePassword,
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

                    /// Repeat Password
                    customtextField(
                      keyboard: TextInputType.visiblePassword,
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
                      validator: (val) => MyValidators.repeatPasswordValidator(
                        value: val,
                        password: passwordController.text,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    /// Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AuthCubit.get(context).registerCubit(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: phoneController.text.trim(),
                              nationalId: nationalIdController.text.trim(),
                              gender: genderController.text
                                  .trim()
                                  .toLowerCase(),
                              password: passwordController.text.trim(),
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
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// Go to Login
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
    );
  }
}
