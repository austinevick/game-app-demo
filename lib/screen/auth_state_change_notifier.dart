import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_provider.dart';
import 'home_screen.dart';
import 'signin_screen.dart';

class AuthStateChangeNotifier extends StatelessWidget {
  const AuthStateChangeNotifier({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        body: ref.watch(sessionProvider).when(
            data: (data) =>
                data == null ? const SignInScreen() : const HomeScreen(),
            error: (e, t) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink()),
      );
    });
  }
}
