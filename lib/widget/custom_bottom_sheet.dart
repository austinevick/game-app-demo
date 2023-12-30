import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:game_app/widget/custom_button.dart';

void showCommonModalBottomSheet({
  required BuildContext context,
  EdgeInsetsGeometry? bottomSheetPadding,
  Widget? child,
  Function()? onTap,
  bool? isPopFromPlayWithClientDialog,
}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.transparent,
                padding: bottomSheetPadding ??
                    const EdgeInsets.only(left: 29, right: 29, bottom: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          width: 100,
                          height: 40,
                          text: 'Close',
                          color: Colors.black45.withOpacity(0.3),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CustomButton(
                          width: 100,
                          height: 40,
                          text: 'Back',
                          color: Colors.black45.withOpacity(0.3),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: child ?? const Offstage(),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      });
}
