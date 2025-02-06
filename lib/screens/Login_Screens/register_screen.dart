import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
import 'package:movie_app/authentication/auth_states.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register Screen";

  final String title;

  RegisterScreen({super.key, required this.title});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccesStates) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else if (state is FailedToRegisterStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                height: 40,
                alignment: Alignment.bottomCenter,
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            title: Text(
              "register".tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (input) {
                        if (nameController.text.isEmpty) {
                          return "User Name Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: "name".tr(),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFFFFFFFF),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: (input) {
                        if (nameController.text.isEmpty) {
                          return "Email Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: "email".tr(),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xFFFFFFFF),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: phoneController,
                      validator: (input) {
                        if (nameController.text.isEmpty) {
                          return "Phone Number Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: "phone_number".tr(),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFFFFFFFF),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (input) {
                        if (nameController.text.isEmpty) {
                          return "Password Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: "password".tr(),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFFFFFFF),
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Color(0xFFFFFFFF),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: rePasswordController,
                      validator: (input) {
                        if (nameController.text.isEmpty) {
                          return "Re Password Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelText: "re_password".tr(),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xFFFFFFFF),
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Color(0xFFFFFFFF),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(16)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            rePassword: rePasswordController.text,
                          );
                        }
                      },
                      child: Text(
                        state is LoginLoadingStates
                            ? "Loading..."
                            : "create_account".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "already_have_account?".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: "login".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ToggleSwitch(
                    minWidth: 50.28,
                    initialLabelIndex:
                        context.locale.toString() == 'en' ? 0 : 1,
                    cornerRadius: 30,
                    activeBgColor: [Theme.of(context).primaryColor],
                    activeFgColor: Theme.of(context).scaffoldBackgroundColor,
                    inactiveBgColor: Theme.of(context).scaffoldBackgroundColor,
                    inactiveFgColor: Theme.of(context).primaryColor,
                    totalSwitches: 2,
                    icons: [
                      FontAwesomeIcons.flagUsa,
                      MdiIcons.abjadArabic,
                    ],
                    onToggle: (index) {
                      if (index == 1) {
                        context.setLocale(
                          Locale('ar'),
                        );
                      } else {
                        context.setLocale(
                          Locale('en'),
                        );
                      }
                      print('switched to: $index');
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
