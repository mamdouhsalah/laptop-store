import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:state_mangement/core/manger/cubit/style_cubit.dart';
import 'package:state_mangement/core/widget/CustomTextField.dart';
import 'package:state_mangement/feature/authentication/cubit/auth_cubit.dart';
import 'package:state_mangement/core/widget/validator.dart';
import 'package:state_mangement/feature/home/view/screen/home_screen.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeCubit>().state;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20.sp, color: theme.textColor),
        ),
        backgroundColor: theme.backgroundColor,
        iconTheme: IconThemeData(color: theme.textColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              customtextField(
                keyboard: TextInputType.text,
                controller: nameController,
                hint: "Enter your full name",
                label: "Full Name",
                icon: Icons.person,
                textColor: theme.textColor,
                buttonColor: theme.buttonColor,
                validator: (val) => MyValidators.displayNamevalidator(val),
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
                keyboard: TextInputType.phone,
                controller: phoneController,
                hint: "Enter your phone",
                label: "Phone Number",
                icon: Icons.phone,
                textColor: theme.textColor,
                buttonColor: theme.buttonColor,
                validator: (val) => MyValidators.phoneValidator(val),
              ),
              SizedBox(height: 16.h),
              customtextField(
                keyboard: TextInputType.text,
                controller: addressController,
                hint: "Enter your address",
                label: "Address",
                icon: Icons.home,
                textColor: theme.textColor,
                buttonColor: theme.buttonColor,
              ),
              SizedBox(height: 16.h),
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
                validator: (val) => MyValidators.passwordValidator(val),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoginSuccessState) {
                      if (state.data['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.data['message']),
                            backgroundColor: theme.buttonColor,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else if (state.data['status'] == 'error') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.data['message']),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.buttonColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        //   AuthCubit.get(context).updateProfile(
                        //     name: nameController.text,
                        //     email: emailController.text,
                        //     phone: phoneController.text,
                        //     address: addressController.text,
                        //     password: passwordController.text,
                        //   );
                        // }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: theme.backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
