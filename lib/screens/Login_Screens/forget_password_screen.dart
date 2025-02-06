import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const String routeName = "Forget Password Screen";

  ForgetPasswordScreen({super.key});

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "forget_password".tr(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/Forgot password.png"),
            SizedBox(height: 24),
            Container(
               decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).focusColor,
              ),
              child: TextField(
                controller: emailController,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall,
                decoration: InputDecoration(
                  labelText: "email".tr(),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall,
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
            SizedBox(height: 24),
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
              child: Text(
                "reset_password".tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
