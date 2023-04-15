import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasooh/app/Style/Icons.dart';
import 'package:nasooh/app/constants.dart';

class OneOreder extends StatelessWidget {
  const OneOreder({super.key});

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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: const Color(0xffFFBD00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              coinss,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "طلب #6532810",
                  style: Constants.subtitleRegularFont,
                ),
                Text(
                  "لقد استلمت ارباحك بنجاح",
                  style: Constants.secondaryTitleRegularFont,
                )
              ],
            ),
          ),
          const Spacer(),
          const Text(
            "120 SR",
            style: Constants.mainTitleFont,
          )
        ],
      ),
    );
  }
}
