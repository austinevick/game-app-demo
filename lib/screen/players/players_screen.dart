import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/provider/game_provider.dart';
import 'package:game_app/screen/players/players_list_tile.dart';
import 'package:game_app/widget/custom_textfield.dart';
import 'package:game_app/widget/loading_widget.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Players')),
      body: Consumer(
        builder: (context, ref, child) {
          final controller = ref.watch(gameProvider);
          return SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomTextfield(
                  autoFocus: true,
                  hintText: 'Search players by name or bank account',
                  controller: controller.searchPlayersCtrl,
                  onChanged: (value) => controller.onPlayersListSearch(),
                ),
                ref.watch(playersListProvider).when(
                    data: (data) => Expanded(
                          child: controller.searchPlayersCtrl.text.isNotEmpty
                              ? controller.searchedPlayersList.isEmpty
                                  ? const Center(
                                      child: Text('Player not found'),
                                    )
                                  : ListView.separated(
                                      itemBuilder: (context, i) =>
                                          PlayersListTile(
                                              onTap: () => {},
                                              data: controller
                                                  .searchedPlayersList[i]),
                                      separatorBuilder: (e, i) =>
                                          const Divider(),
                                      itemCount:
                                          controller.searchedPlayersList.length)
                              : ListView.separated(
                                  itemBuilder: (context, i) => PlayersListTile(
                                      onTap: () => ref
                                          .read(gameProvider)
                                          .getGameDetailsById(),
                                      data: data[i]),
                                  separatorBuilder: (e, i) => const Divider(),
                                  itemCount: data.length),
                        ),
                    error: (e, t) => const SizedBox.shrink(),
                    loading: () => const Expanded(child: LoadingWidget()))
              ],
            ),
          );
        },
      ),
    );
  }
}
