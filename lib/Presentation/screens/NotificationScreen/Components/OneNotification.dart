import 'package:flutter/material.dart';

import 'package:nasooh/app/constants.dart';

class OneNotification extends StatelessWidget {
  const OneNotification({super.key, required this.date, required this.description, required this.notificationId});

  final String date;
  final String description;
  final String notificationId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            // ignore: use_full_hex_values_for_flutter_colors
            color: const Color(0XFF5C5E6B1A).withOpacity(0.1)),
        const BoxShadow(color: Colors.white),
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Constants.secondaryTitleFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    date,
                    // "12/2/2022 - 10:46 ص",
                    style: Constants.subtitleRegularFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                        text:  TextSpan(children: [
                      const TextSpan(
                        text: "رقم الطلب  ",
                        style: Constants.subtitleRegularFont,
                      ),
                      TextSpan(
                        text: description,
                        style: Constants.secondaryTitleFont,
                      )
                    ])),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
