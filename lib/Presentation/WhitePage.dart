import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WhitePage extends StatelessWidget {
  const WhitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      body: SvgPicture.asset("assets/images/SVGs/consulta.svg"),
    ));
  }
}
