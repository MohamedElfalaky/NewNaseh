import 'package:flutter/material.dart';
import 'package:nasooh/app/constants.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressedHandler;
  final String? txt;
  final Color? btnColor;
  final Color? txtColor;
  final dynamic txtSize;
  final bool? isBold;
  final Widget? prefixWidget;

  const MyButton(
      {super.key,
      this.onPressedHandler,
      this.txt,
      this.btnColor,
      this.txtColor,
      this.txtSize,
      this.isBold,
      this.prefixWidget});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        textStyle: const TextStyle(fontWeight: FontWeight.normal),
        elevation: 2,
        backgroundColor: btnColor ?? Constants.primaryAppColor,
      ),
      onPressed: onPressedHandler,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? const SizedBox(),
            Container(
              margin: const EdgeInsets.all(3),
              child: Text(
                '$txt',
                style: TextStyle(
                    fontWeight:
                        isBold == true ? FontWeight.bold : FontWeight.normal,
                    fontFamily: Constants.mainFont,
                    fontSize: txtSize ?? 16,
                    color: txtColor ?? Constants.whiteAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
