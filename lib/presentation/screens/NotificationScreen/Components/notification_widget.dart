import 'package:flutter/material.dart';
import 'package:nasooh/app/constants.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key,
      required this.date,
      required this.description,
      required this.notificationId,
      required this.orderId});

  final String date;
  final String description;
  final String notificationId;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow:   [
            BoxShadow(
                color: Constants.primaryAppColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Constants.primaryAppColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            // child: SvgPicture.asset(
            //   coinss,
            // ),
            child: const Icon(
              Icons.notification_add,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  description,
                  style: Constants.secondaryTitleFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  date.replaceAll(' ', '\n'),
                  style: Constants.subtitleRegularFont,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                      text: "رقم الطلب  ",
                      style: Constants.subtitleRegularFont,
                    ),
                    TextSpan(
                      text: orderId.toString(),
                      style: Constants.secondaryTitleFont,
                    )
                  ])),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
