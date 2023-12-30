import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          20,
          (index) => const Padding(
                padding: EdgeInsets.all(14.0),
                child: FadeShimmer(
                  height: 65,
                  width: double.infinity,
                  radius: 4,
                  highlightColor: Color(0xfff6f7f8),
                  baseColor: Color.fromARGB(88, 230, 232, 235),
                ),
              )),
    );
  }
}
