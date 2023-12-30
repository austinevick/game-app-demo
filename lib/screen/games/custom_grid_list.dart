import 'package:flutter/material.dart';

class CustomGridList extends StatelessWidget {
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  const CustomGridList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 8, crossAxisSpacing: 8, crossAxisCount: 2),
      itemBuilder: itemBuilder,
    );
  }
}
