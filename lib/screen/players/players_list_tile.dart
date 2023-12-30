import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/players_model.dart';

class PlayersListTile extends StatelessWidget {
  final PlayersResponseData data;
  final VoidCallback onTap;
  const PlayersListTile({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(data.username!.substring(0, 1)),
        ),
        title: Text(
          data.username!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text("${data.accountNumber!} (${data.bankName!})"),
      );
    });
  }
}
