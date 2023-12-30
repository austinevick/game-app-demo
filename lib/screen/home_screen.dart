import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/provider/game_bloc_provider.dart';
import 'package:game_app/screen/games/daily_games.dart';
import 'package:game_app/screen/games/direct_and_permutation_games.dart';
import 'package:game_app/widget/custom_button.dart';

import '../provider/game_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final controller = ref.watch(gameBlocProvider);
        return PopScope(
          canPop: controller.selectedGames.isEmpty,
          onPopInvoked: (didPop) {
            if (controller.selectedGames.isNotEmpty) {
              controller.clearSelectedGames();
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Games'), centerTitle: true),
            body: RefreshIndicator(
              onRefresh: () async {
                await ref.refresh(gameProvider).getGameList();
                await ref.refresh(gameProvider).getDirectAndPermutationGames();
              },
              child: const Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DirectAndPermutationGames(),
                      DailyGames(),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: controller.selectedGames.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: CustomButton(
                          textAlign: Alignment.center,
                          radius: 8,
                          text:
                              '${controller.selectedGames.length} Games selected',
                          color: Colors.green,
                          isEnabled: controller.selectedGames.isNotEmpty,
                          onPressed: () =>
                              ref.read(gameProvider).getGameDetailsById(),
                        ),
                      )),
          ),
        );
      },
    );
  }
}
