import 'package:flutter/material.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class OutcomeAndRate extends StatelessWidget {
  String? title;
  String? subtitle;
  Color? colorr;
  var iconn;

  OutcomeAndRate(
      {super.key, this.title, this.subtitle, this.iconn, this.colorr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyApplication.widthClc(context, 163),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: colorr!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: colorr!.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: TextStyle(fontSize: 10, fontFamily: Constants.mainFont),
              ),
              Text(
                subtitle!,
                style: TextStyle(color: colorr, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
