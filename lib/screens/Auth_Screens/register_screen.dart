import 'package:avatar_plus/avatar_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:movie_app/authentication/auth_cupit.dart';
import 'package:movie_app/authentication/auth_states.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register Screen";

  RegisterScreen({super.key});

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
  int selectedAvaterId = 1;

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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 110,
                        aspectRatio: 19 / 5,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.3,
                      ),
                      items: List.generate(100, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAvaterId = index + 1;
                            });
                            print("Selected Avatar ID: $selectedAvaterId");
                          },
                          child: AvatarPlus(
                            "$index",
                            height: 100,
                            width: 94,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Avatar",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).focusColor,
                      ),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name Must Not Be Empty";
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email Must Not Be Empty";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Email Not Valid";
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone Must Not Be Empty";
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password Must Not Be Empty";
                          } else {
                            return null;
                          }
                        },
                        obscureText: false,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "RePassword Must Not Be Empty";
                          }
                          if (passwordController.text != value) {
                            return "RePassword Not Match";
                          } else {
                            return null;
                          }
                        },
                        obscureText: false,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print("Selected Avatar ID: $selectedAvaterId");
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).register(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                confirmPassword: rePasswordController.text,
                                avaterId: selectedAvaterId);
                          }
                        },
                        child: Text(
                          "create_account".tr(),
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
                        Navigator.pop(context);
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
                      inactiveBgColor:
                          Theme.of(context).scaffoldBackgroundColor,
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
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
