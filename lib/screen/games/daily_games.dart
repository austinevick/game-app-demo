import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/provider/game_provider.dart';

import '../../provider/game_bloc_provider.dart';
import '../../widget/loading_widget.dart';
import 'game_cards.dart';

class DailyGames extends StatelessWidget {
  const DailyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final controller = ref.watch(gameBlocProvider);

        return ref.watch(gameTypeProvider).when(
              data: (data) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                    children: List.generate(
                        data.length,
                        (i) => GameCard(
                              onTap: () =>
                                  controller.addAndRemoveGames(data[i].id!),
                              selectedGames: data[i].id!,
                              text: data[i].title!,
                              imageUrl: data[i].image!,
                              cardColor: data[i].colorCode!.toColor(),
                            ))),
              ),
              error: (e, t) => const SizedBox.shrink(),
              loading: () => const LoadingWidget(),
            );
      },
    );
  }
}
