import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/provider/game_provider.dart';

import '../../widget/loading_widget.dart';
import 'game_cards.dart';

class DirectAndPermutationGames extends StatelessWidget {
  const DirectAndPermutationGames({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(directAndPermutationGameProvider).when(
              data: (data) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                    children: List.generate(
                        data.length,
                        (i) => GameCard(
                              onTap: () {},
                              selectedGames: 0,
                              text: data[i].name!,
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
