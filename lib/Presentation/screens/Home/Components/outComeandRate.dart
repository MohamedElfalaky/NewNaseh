import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class OutcomeAndRate extends StatelessWidget {
  String? title;
  String? subtitle;
  Color? color;
  String? assetName;

  OutcomeAndRate(
      {super.key, this.title, this.subtitle, this.assetName, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyApplication.widthClc(context, 163),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(assetName! )
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: const TextStyle(fontSize: 10, fontFamily: Constants.mainFont),
              ),
              Text(
                subtitle!,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
