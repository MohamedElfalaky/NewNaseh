import 'package:flutter/material.dart';
import 'package:nasooh/Presentation/widgets/custom_button.dart';

import '../../app/styles/icons.dart';

class Alert {
  static Future<void> alert(
      {BuildContext? context,
      String? titleAction,
      String? content,
      void Function()? action}) async {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 341,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.black, // Border color
                width: 2.0, // Border width
              ),
            ),
            child: Column(
              children: [
                Image.asset(
                  dialogIcon,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
                Text(
                  content!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Cairo",
                  ),
                ),
                const SizedBox(height: 10), // Add 10 pixels spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    onPressedHandler: action,
                    txt: titleAction,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
