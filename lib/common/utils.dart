import 'package:flutter/material.dart';

final navigatorkey = GlobalKey<NavigatorState>();
void customSnackBar(data) =>
    ScaffoldMessenger.of(navigatorkey.currentContext!).showSnackBar(SnackBar(
        duration: const Duration(minutes: 1),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      onPressed: () =>
                          ScaffoldMessenger.of(navigatorkey.currentContext!)
                              .removeCurrentSnackBar(),
                      child: const Text(
                        'DISMISS',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ))),
            )
          ],
        )));

Future<T?> push<T>(Widget child) => Navigator.of(navigatorkey.currentContext!)
    .push(MaterialPageRoute(builder: (context) => child));

void pop<T extends Object?>([T? result]) =>
    Navigator.of(navigatorkey.currentContext!).pop();

Future<void> pushReplacement(Widget child) =>
    Navigator.of(navigatorkey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) => child));

Future<void> pushAndRemoveUntil(Widget child) =>
    Navigator.of(navigatorkey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => child), (c) => false);

void loadingDialog() => showDialog(
    barrierDismissible: false,
    context: navigatorkey.currentContext!,
    builder: (ctx) => Container(
          color: Colors.black26.withOpacity(0.1),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
