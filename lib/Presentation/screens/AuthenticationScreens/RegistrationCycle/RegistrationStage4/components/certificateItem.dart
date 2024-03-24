import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasooh/Data/cubit/FrontEndCubits/cubit/add_cirtificate_cubit.dart';
import 'package:nasooh/Presentation/screens/AuthenticationScreens/RegistrationCycle/RegistrationStage4/RegistrationStage4.dart';
import 'package:nasooh/app/constants.dart';

class CertificateItem extends StatelessWidget {
  final String cert;
  final String staticId;
  final bool register;

  const CertificateItem(
      {super.key,
      required this.cert,
      required this.staticId,
      required this.register});

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
            cert,
            style:
                const TextStyle(fontFamily: Constants.mainFont, fontSize: 10),
          ),
          const SizedBox(
            width: 8,
          ),
          if (register == true)
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
                        (element) => element["id"].toString() == staticId);

                    BlocProvider.of<AddCertificateCubit>(context)
                        .addCertificate();

                    // print(widget.staticId);
                    // print(certiList[0]["id"]);
                  },
                  child: const Icon(
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
