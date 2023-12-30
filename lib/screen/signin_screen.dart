import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/provider/game_provider.dart';

import '../common/utils.dart';
import '../widget/button_loader.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final controller = ref.watch(gameProvider);
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  CustomTextfield(
                    hintText: 'Username',
                    controller: controller.usernameCtrl,
                  ),
                  const SizedBox(height: 16),
                  CustomTextfield(
                    hintText: 'Password',
                    controller: controller.passwordCtrl,
                  ),
                  const SizedBox(height: 60),
                  CustomButton(
                    onPressed: () =>
                        ref.read(gameProvider).login().then((value) {
                      if (value.status == 200) {
                        pushAndRemoveUntil(const HomeScreen());
                      }
                    }),
                    color: Colors.red,
                    child: const ButtonLoader(isLoading: false, text: 'LOGIN'),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
