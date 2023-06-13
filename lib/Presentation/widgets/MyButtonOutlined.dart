import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/constants.dart';

class MyButtonOutlined extends StatelessWidget {
  final void Function()? onPressedHandler;
  final String? txt;
  final Color? btnColor;
  final Color? txtColor;
  final double? txtSize;
  final bool? isBold;
  final Widget? prefixWidget;
  const MyButtonOutlined(
      {super.key, this.onPressedHandler,
      this.txt,
      this.btnColor,
      this.txtColor,
      this.txtSize,
      this.isBold,
      this.prefixWidget});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          textStyle: const TextStyle(fontWeight: FontWeight.normal),
          side: const BorderSide(color: Colors.black)),
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
                    fontSize: txtSize ?? 14,
                    color: txtColor ?? Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
