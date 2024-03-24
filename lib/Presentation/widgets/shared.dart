import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/constants.dart';

class AppbarButton extends StatelessWidget {
  final Icon? myIcon;
  final Function()? onTapHandler;

  const AppbarButton({super.key, this.myIcon, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapHandler,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0XFFFFFFFF).withOpacity(0.2)),
        child: myIcon,
      ),
    );
  }
}

class GoBack extends StatelessWidget {
  const GoBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          'assets/images/SVGs/back.svg',
          width: 14,
          height: 14,
        ),
      ),
    );
  }
}

class MyPrefixWidget extends StatelessWidget {
  const MyPrefixWidget({Key? key, this.svgString}) : super(key: key);
  final String? svgString;

  String getSvgString() {
    return svgString == null ? 'assets/images/SVGs/flag.svg' : svgString!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // shape: BoxShape.rectangle,
          color: Color(0xffEEEEEE),
        ),
        child: SvgPicture.asset(
          getSvgString(),
        ),
      ),
    );
  }
}

class Back extends StatelessWidget {
  const Back({Key? key, this.header}) : super(key: key);
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const GoBack(),
        const SizedBox(
          width: 16,
        ),
        Text((header ?? "").tr,
            textAlign: TextAlign.right, style: Constants.headerNavigationFont),
      ],
    );
  }
}

class MyBackButton extends StatelessWidget {
  MyBackButton({super.key, this.onPressed, this.hasValue = false});

  void Function()? onPressed;
  bool hasValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Constants.whiteAppColor,
            border: Border.all(color: const Color(0XFFDADADA)),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff5c5e6b1a).withOpacity(0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 4)
            ]),
        height: 42,
        width: 42,
        child: BackButton(
          onPressed: hasValue
              ? onPressed
              : () {
                  Navigator.pop(context);
                },
          color: const Color(0xff575762),
        ),
      ),
    );
  }
}
