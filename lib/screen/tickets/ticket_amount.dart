import 'package:flutter/material.dart';

import '../../model/game_detail_model.dart';

class TicketAmount extends StatelessWidget {
  final GamedetailResponseData data;
  const TicketAmount({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return data.amount!.isNotEmpty
        ? Text('Amount Per ticket: ${data.amount}',
            style: Theme.of(context).textTheme.titleMedium)
        : Text('Enter amount between N${data.minAmount} to N${data.maxAmount}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium);
  }
}
