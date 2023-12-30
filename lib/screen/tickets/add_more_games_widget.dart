import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/common/constants.dart';

import '../../provider/game_bloc_provider.dart';
import '../../provider/game_provider.dart';
import '../../widget/custom_button.dart';
import '../games/custom_grid_list.dart';
import '../games/game_cards.dart';

class AddMoreGamesWidget extends StatelessWidget {
  const AddMoreGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final controller = ref.watch(gameBlocProvider);
      return SafeArea(
        child: Column(
          children: [
            AppBar(
                title: Text(
                    '${controller.selectedGames.length + 1} Games Selected'),
                centerTitle: true),
            Expanded(
                child: ref.watch(gameTypeProvider).when(
                    data: (data) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CustomGridList(
                              itemBuilder: (ctx, i) {
                                return GameCard(
                                  onTap: () =>
                                      controller.addAndRemoveGames(data[i].id!),
                                  selectedGames: data[i].id!,
                                  text: data[i].title!,
                                  imageUrl: data[i].image!,
                                  cardColor: data[i].colorCode!.toColor(),
                                );
                              },
                              itemCount: data.length),
                        ),
                    error: (e, t) => Center(),
                    loading: () => Center())),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: CustomButton(
                textAlign: Alignment.center,
                radius: 8,
                text: '${controller.selectedGames.length} Games selected',
                color: Colors.green,
                isEnabled: controller.selectedGames.isNotEmpty,
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(gameProvider).getGameDetailsById();
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
