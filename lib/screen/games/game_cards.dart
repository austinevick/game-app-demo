import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_app/provider/game_bloc_provider.dart';

class GameCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Color cardColor;
  final VoidCallback onTap;
  final int selectedGames;
  const GameCard(
      {super.key,
      required this.text,
      required this.imageUrl,
      required this.cardColor,
      required this.onTap,
      required this.selectedGames});

  @override
  Widget build(BuildContext context) {
    const double size = 120;
    return Consumer(builder: (context, ref, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          minWidth: size,
          height: size,
          elevation: 0,
          highlightElevation: 0,
          shape: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14)),
          color: cardColor,
          padding: const EdgeInsets.all(0),
          onPressed: onTap,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageUrl.endsWith('.png')
                        ? Image.network(imageUrl, height: 35)
                        : SvgPicture.network(imageUrl),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ref.watch(gameBlocProvider).selectedGames.contains(selectedGames)
                  ? Container(
                      width: size,
                      height: size,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black45.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(14)),
                      child: const Icon(Icons.check, color: Colors.white),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}
