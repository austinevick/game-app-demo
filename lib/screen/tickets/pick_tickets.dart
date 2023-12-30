import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/provider/game_bloc_provider.dart';
import 'package:game_app/provider/game_provider.dart';
import 'package:game_app/screen/tickets/add_more_games_widget.dart';
import 'package:game_app/screen/tickets/ticket_amount.dart';
import 'package:game_app/widget/custom_textfield.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../model/game_detail_model.dart';
import '../../storage/storage_provider.dart';
import '../../widget/custom_button.dart';

class PickTickets extends StatefulWidget {
  final List<GamedetailResponseData> gameDetails;
  const PickTickets({super.key, required this.gameDetails});

  @override
  State<PickTickets> createState() => _PickTicketsState();
}

class _PickTicketsState extends State<PickTickets> {
  List<TextEditingController> amountPerTickerCtrl = [];
  final pageCtrl = PageController();
  final scrollCtrl = ScrollController();
  int currentIndex = 0;
  int selectedTicket = 1;

  @override
  void initState() {
    amountPerTickerCtrl
        .add(TextEditingController(text: widget.gameDetails[0].minAmount!));
    super.initState();
  }

  num getTotalAmountPerTicker(int i) {
    if (widget.gameDetails[i].amount!.isEmpty) {
      // var amount = amountPerTickerCtrl[i].text.isEmpty
      //     ? widget.gameDetails[i].minAmount!
      //     : amountPerTickerCtrl[i].text;
      if (amountPerTickerCtrl[i].text.isNotEmpty) {
        return selectedTicket * num.parse(amountPerTickerCtrl[i].text);
      }
      return selectedTicket * num.parse(widget.gameDetails[i].minAmount!);
    } else {
      return selectedTicket * num.parse(widget.gameDetails[i].amount!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final controller = ref.watch(gameBlocProvider);
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('How Many Tickets?',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    controller: scrollCtrl,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          widget.gameDetails.length,
                          (i) => Row(
                                children: [
                                  i == 0
                                      ? const SizedBox.shrink()
                                      : Container(
                                          width: 40,
                                          height: 4,
                                          color: Colors.grey.shade300),
                                  CustomButton(
                                      height: 45,
                                      text: ("${i + 1}").toString(),
                                      width: 45,
                                      radius: 50,
                                      color: currentIndex == i
                                          ? Colors.green
                                          : Colors.grey.shade200),
                                ],
                              )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: PageView(
                        controller: pageCtrl,
                        onPageChanged: (value) => setState(() {
                              currentIndex = value;
                              amountPerTickerCtrl.add(TextEditingController());
                            }),
                        children: List.generate(
                            widget.gameDetails.length,
                            (i) => SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CustomButton(
                                        text: widget.gameDetails[i].title,
                                        textColor: Colors.black,
                                        radius: 6,
                                        borderSide: const BorderSide(),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                              text: 'Add more',
                                              textColor: Colors.red,
                                              radius: 6,
                                              width: 150,
                                              height: 40,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showBarModalBottomSheet(
                                                    context: context,
                                                    builder: (ctx) =>
                                                        const AddMoreGamesWidget());
                                              },
                                              borderSide: const BorderSide(),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: CustomButton(
                                              text: 'Remove',
                                              textColor: Colors.red,
                                              radius: 6,
                                              width: 150,
                                              height: 40,
                                              onPressed: () async {
                                                controller.addAndRemoveGames(
                                                    widget.gameDetails[i].id!);
                                                await ref
                                                    .read(gameProvider)
                                                    .getGameDetailsById();
                                                if (!context.mounted) return;
                                                Navigator.of(context).pop();
                                              },
                                              borderSide: const BorderSide(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25),
                                      Text(
                                          'Tap to select the number of Tickets per game?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        children: List.generate(
                                            int.parse(widget.gameDetails[i]
                                                .availableTicketQty!),
                                            (i) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: CustomButton(
                                                    height: 40,
                                                    textAlign: Alignment.center,
                                                    radius: 4,
                                                    width: 80,
                                                    textColor: selectedTicket ==
                                                            (i + 1)
                                                        ? Colors.white
                                                        : Colors.black45,
                                                    color: selectedTicket ==
                                                            (i + 1)
                                                        ? Colors.deepOrange
                                                        : Colors.grey.shade200,
                                                    text: '${i + 1}',
                                                    onPressed: () => setState(
                                                        () => selectedTicket =
                                                            i + 1),
                                                  ),
                                                )),
                                      ),
                                      const SizedBox(height: 20),
                                      TicketAmount(data: widget.gameDetails[i]),
                                      const SizedBox(height: 6),
                                      widget.gameDetails[i].amount!.isNotEmpty
                                          ? const SizedBox.shrink()
                                          : CustomTextfield(
                                              hintText: '50',
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: amountPerTickerCtrl[
                                                  currentIndex],
                                              onChanged: (value) {
                                                amountPerTickerCtrl.add(
                                                    TextEditingController());
                                                getTotalAmountPerTicker(i);
                                                setState(() {});
                                              },
                                            ),
                                      const SizedBox(height: 16),
                                      Text('',
                                          // 'Total Amount: N${getTotalAmountPerTicker(i)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      const SizedBox(height: 20),
                                      const Text(
                                          'The more your staking amount, the bigger your winning'),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomButton(
                                                      height: 60,
                                                      width: 60,
                                                      color:
                                                          Colors.grey.shade300,
                                                      onPressed: () {
                                                        pageCtrl.previousPage(
                                                            duration:
                                                                Durations.long1,
                                                            curve:
                                                                Curves.easeIn);
                                                        scrollCtrl.animateTo(
                                                            scrollCtrl.offset -
                                                                widget
                                                                    .gameDetails
                                                                    .length -
                                                                50,
                                                            curve:
                                                                Curves.linear,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500));
                                                      },
                                                      child: const Icon(Icons
                                                          .keyboard_arrow_left)),
                                                  CustomButton(
                                                      height: 60,
                                                      width: 60,
                                                      color:
                                                          Colors.grey.shade300,
                                                      onPressed: () {
                                                        pageCtrl.nextPage(
                                                            duration:
                                                                Durations.long1,
                                                            curve:
                                                                Curves.easeIn);
                                                        scrollCtrl.animateTo(
                                                            scrollCtrl.offset +
                                                                widget
                                                                    .gameDetails
                                                                    .length +
                                                                50,
                                                            curve:
                                                                Curves.linear,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500));
                                                      },
                                                      child: const Icon(Icons
                                                          .keyboard_arrow_right)),
                                                ],
                                              ),
                                              const SizedBox(height: 25),
                                              CustomButton(
                                                text: 'Pick Numbers',
                                                color: primaryColor,
                                                radius: 8,
                                                onPressed: () async {
                                                  final provider =
                                                      ref.read(gameProvider);
                                                  final userId =
                                                      await StorageProvider
                                                          .getUserId();

                                                  provider.addAllTicketData(
                                                      widget.gameDetails);

                                                  provider.bookingGameApi(
                                                      provider.ticketData);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
