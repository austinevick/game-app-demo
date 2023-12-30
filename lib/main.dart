import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game_app/common/constants.dart';
import 'package:game_app/common/utils.dart';

import 'screen/auth_state_change_notifier.dart';
import 'widget/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        navigatorKey: navigatorkey,
        home: const AuthStateChangeNotifier(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TextEditingController> numberCtrl = [];
  List<FocusNode> focusNode = [];
  int index = 1;

  int selectedTicket = 1;
  bool useTextField = true;
  @override
  void initState() {
    focusNode.add(FocusNode());
    numberCtrl.add(TextEditingController());

    super.initState();
  }

  List<int> n = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Permutation'),
        ),
        body: Column(
          children: [
            const TabBar(tabs: [Tab(text: 'Manual'), Tab(text: 'Auto')]),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      index != 4
                          ? const Text(
                              'Min: 3 Max: 30',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        '${(index - 1)}/30',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Wrap(
                          children: List.generate(numberCtrl.length, (i) {
                        final p = RegExp(r'[0-30]');

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 60,
                            child: TextField(
                              autofocus: true,
                              controller: numberCtrl[i],
                              focusNode: focusNode[i],
                              style: const TextStyle(fontSize: 28),
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                /// FilteringTextInputFormatter.allow(p)
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  if (value.length == 1) {
                                    index++;
                                    numberCtrl.add(TextEditingController());
                                    focusNode.add(FocusNode());
                                    Future.delayed(
                                        const Duration(milliseconds: 100),
                                        () => focusNode[i].nextFocus());
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 3, color: Colors.red)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(width: 3))),
                            ),
                          ),
                        );
                      })),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            n.length,
                            (i) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CustomButton(
                                    height: 40,
                                    textAlign: Alignment.center,
                                    radius: 4,
                                    width: 80,
                                    textColor: i == (i + 1)
                                        ? Colors.white
                                        : Colors.black45,
                                    color: i == (i + 1)
                                        ? Colors.deepOrange
                                        : Colors.grey.shade200,
                                    text: '${n[i]}',
                                  ),
                                ))),
                    const SizedBox(height: 50),
                    Wrap(
                      children: List.generate(
                          30,
                          (i) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomButton(
                                  height: 40,
                                  textAlign: Alignment.center,
                                  radius: 4,
                                  width: 80,
                                  textColor: n.contains(i)
                                      ? Colors.white
                                      : Colors.black45,
                                  color: n.contains(i)
                                      ? Colors.deepOrange
                                      : Colors.grey.shade200,
                                  text: '${i + 1}',
                                  onPressed: () => setState(() {
                                    // if (n.length == 4) return;

                                    if (n.contains(i)) {
                                      n.remove(i);
                                    } else {
                                      n.add(i);
                                    }
                                  }),
                                ),
                              )),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  color: Colors.red,
                  text: 'CLEAR',
                  radius: 8,
                  onPressed: () {
                    setState(() => numberCtrl.length--);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomButton(
                color: Colors.lightBlue,
                text: 'OK',
                radius: 8,
                onPressed: () => {},
              )),
            ],
          ),
        ),
      ),
    );
  }
}
