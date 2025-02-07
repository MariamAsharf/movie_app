import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
import 'package:movie_app/authentication/auth_states.dart';
import 'package:movie_app/screens/Login_Screens/register_screen.dart';

import 'package:toggle_switch/toggle_switch.dart';

import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login Screen";

  LoginScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccesStates) {
          Navigator.pushReplacementNamed(
              context, ForgetPasswordScreen.routeName);
        } else if (state is FailedToLoginStates) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/movie.png",
                    height: 118,
                  ),
                  SizedBox(height: 69),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).focusColor,
                    ),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Color(0xFFFFFFFF),
                          ),
                      decoration: InputDecoration(
                        labelText: "email".tr(),
                        labelStyle:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Color(0xFFFFFFFF),
                                ),
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
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password Must Not Be Empty";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Color(0xFFFFFFFF),
                          ),
                      decoration: InputDecoration(
                        labelText: "password".tr(),
                        labelStyle:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: Color(0xFFFFFFFF),
                                ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgetPasswordScreen.routeName);
                        },
                        child: Text(
                          "forget_password?".tr(),
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          maximumSize: WidgetStatePropertyAll(
                            Size.fromWidth(double.infinity),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: Text(
                          state is LoginLoadingStates
                              ? "Loading..."
                              : "login".tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "dont_have_account?".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: "create_account".tr(),
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
                  Text(
                    "Or",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.google,
                          size: 25,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "login_with_google".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ],
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
