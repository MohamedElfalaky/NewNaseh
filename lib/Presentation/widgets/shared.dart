import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/constants.dart';
import '../../app/utils/lang/language_constants.dart';

class appbarButton extends StatelessWidget {
  Icon? myIcon;
  Function()? onTapHandler;

  appbarButton({super.key, this.myIcon, this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapHandler,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0XFFFFFFFF).withOpacity(0.2)),
        child: myIcon,
      ),
    );
  }
}

class goBack extends StatelessWidget {
  const goBack({
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
  MyPrefixWidget({Key? key, this.svgString}) : super(key: key);
  String? svgString;
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
  Back({Key? key, this.header}) : super(key: key);
  String? header;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const goBack(),
        const SizedBox(
          width: 16,
        ),
        Text(getTranslated(context, header ?? "")!,
            textAlign: TextAlign.right, style: Constants.headerNavigationFont),
      ],
    );
  }
}

class myBackButton extends StatelessWidget {
  const myBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Constants.whiteAppColor,
            border: Border.all(color: Color(0XFFDADADA)),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Color(0XFF5C5E6B1A).withOpacity(0.2),
                  offset: Offset(0, 4),
                  blurRadius: 4)
            ]),
        height: 42,
        width: 42,
        child: BackButton(
          color: Color(0xff575762),
        ),
      ),
    );
  }
}
