import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/RegistrationStage4.dart';
import 'package:nasooh/app/constants.dart';
import 'package:nasooh/app/utils/myApplication.dart';

class certificateItem extends StatefulWidget {
  final String cert;
  final String staticId;
  const certificateItem(
      {super.key, required this.cert, required this.staticId});

  @override
  State<certificateItem> createState() => _certificateItemState();
}

class _certificateItemState extends State<certificateItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 4, bottom: 4),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
          color: const Color(0XFFEEEEEE),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.cert,
            style: TextStyle(fontFamily: Constants.mainFont, fontSize: 10),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: const Color(0XFF5C5E6B))),
            child: Center(
              child: InkWell(
                onTap: () {
                  certiList.removeWhere(
                      (element) => element["id"].toString() == widget.staticId);

                  BlocProvider.of<AddCirtificateCubit>(context)
                      .addCirtificate();

                  // print(widget.staticId);
                  // print(certiList[0]["id"]);
                },
                child: Icon(
                  Icons.close_outlined,
                  size: 12,
                  color: Color(0XFF5C5E6B),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
